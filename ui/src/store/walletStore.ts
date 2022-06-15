import { SubscriptionRequestInterface } from "@urbit/http-api";
import create from "zustand"
import api from "../api";
import { Account, processAccount, RawAccount } from "../types/Account";
import { Assets } from "../types/Assets";
import { processTokenBalance, RawTokenBalance, TokenBalance } from "../types/TokenBalance";
import { SendTokenPayload } from "../types/SendTransaction";
import { handleBookUpdate, handleTxnUpdate } from "./subscriptions/wallet";
import { RawTransactions, Transaction } from "../types/Transaction";
import { removeDots } from "../utils/format";
import { TokenMetadataStore } from "../types/TokenMetadata";

export function createSubscription(app: string, path: string, e: (data: any) => void): SubscriptionRequestInterface {
  const request = {
    app,
    path,
    event: e,
    err: () => console.warn('SUBSCRIPTION ERROR'),
    quit: () => {
      throw new Error('subscription clogged');
    }
  };
  // TODO: err, quit handling (resubscribe?)
  return request;
}

export interface WalletStore {
  loading: boolean,
  accounts: Account[],
  metadata: TokenMetadataStore,
  assets: {[key: string] : TokenBalance[]},
  selectedTown: number,
  transactions: Transaction[],
  init: () => Promise<void>,
  setLoading: (loading: boolean) => void,
  getAccounts: () => Promise<void>,
  getMetadata: () => Promise<void>,
  getTransactions: () => Promise<void>,
  createAccount: () => Promise<void>,
  importAccount: (mnemonic: string, password: string) => Promise<void>,
  deleteAccount: (account: Account) => Promise<void>,
  setNode: (town: number, ship: string) => Promise<void>,
  sendTransaction: (payload: SendTokenPayload) => Promise<void>,
}

const useWalletStore = create<WalletStore>((set, get) => ({
  loading: true,
  accounts: [],
  metadata: {},
  assets: {},
  selectedTown: 0,
  transactions: [],
  init: async () => {
    // Subscriptions
    api.subscribe(createSubscription('wallet', '/book-updates', handleBookUpdate(get, set)))
    api.subscribe(createSubscription('wallet', '/tx-updates', handleTxnUpdate(get, set)))

    const [balanceData] = await Promise.all([
      api.scry<{[key: string]: { [key: string]: RawTokenBalance }}>({ app: 'wallet', path: '/book' }) || {},
      get().getAccounts(),
      get().getMetadata(),
    ])
    const assets: Assets = {}

    for (let account in balanceData) {
      assets[removeDots(account)] = Object.values(balanceData[account]).map(processTokenBalance)
    }

    set({ assets, loading: false })
  },
  setLoading: (loading: boolean) => set({ loading }),
  getAccounts: async () => {
    const accountData = await api.scry<{[key: string]: RawAccount}>({ app: 'wallet', path: '/accounts' }) || {};
    const accounts = Object.values(accountData).map(processAccount)

    set({ accounts, loading: false })
  },
  getMetadata: async () => {
    const metadata = await api.scry<any>({ app: 'wallet', path: '/token-metadata' })
    set({ metadata })
  },
  getTransactions: async () => {
    const { accounts } = get()
    if (accounts.length) {
      const rawTransactions = await api.scry<RawTransactions>({ app: 'wallet', path: `/transactions/${accounts[0].rawAddress}` })
      const transactions = Object.keys(rawTransactions).map(hash => ({ ...rawTransactions[hash], hash }))
      set({ transactions })
    }
  },
  createAccount: async () => {
    await api.poke({
      app: 'wallet',
      mark: 'zig-wallet-poke',
      json: { create: true }
    })
    await get().getAccounts()
  },
  importAccount: async (mnemonic: string, password: string) => {
    await api.poke({
      app: 'wallet',
      mark: 'zig-wallet-poke',
      json: {
        import: { mnemonic, password }
      }
    })
    await get().getAccounts()
  },
  deleteAccount: async (account: Account) => {
    if (window.confirm(`Are you sure you want to delete this account?\n\n${account.address}`)) {
      await api.poke({
        app: 'wallet',
        mark: 'zig-wallet-poke',
        json: { delete: { pubkey: account.rawAddress } }
      })
      await get().getAccounts()
    }
  },
  setNode: async (town: number, ship: string) => {
    await api.poke({
      app: 'wallet',
      mark: 'zig-wallet-poke',
      json: {
        'set-node': { town, ship }
      }
    })
  },
  sendTransaction: async ({ from, to, town, amount, destination, token, gasPrice, budget }: SendTokenPayload) => {
    console.log(2, JSON.stringify({
      submit: {
        from,
        to,
        town,
        gas: {
          rate: gasPrice,
          bud: budget,
        },
        args: {
          give: {
            token,
            to: destination,
            amount
          },
        }
      }
    }))

    await api.poke({
      app: 'wallet',
      mark: 'zig-wallet-poke',
      json: {
        submit: {
          from,
          to,
          town,
          gas: {
            rate: gasPrice,
            bud: budget,
          },
          args: {
            give: {
              token,
              to: destination,
              amount
            },
          }
        }
      }
    })

    get().getTransactions()
  },
}));

export default useWalletStore;
