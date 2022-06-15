import create from "zustand"
import { persist } from "zustand/middleware"
import api from "../api";
import { handleBookUpdate, handleTxnUpdate } from "./subscriptions/wallet";

interface EditorTextState {
  contract: string
  gall: string
  contractTest: string
  gallTest: string
}

export interface ContractStore {
  loading: boolean
  text: EditorTextState
  setLoading: (loading: boolean) => void
  init: () => Promise<void>
  setTextState: (text: EditorTextState) => void
  submitTest: (isContract: boolean) => Promise<void>
}

const useContractStore = create<ContractStore>(persist<ContractStore>(
  (set, get) => ({
    loading: true,
    text: {
      contract: '',
      gall: '',
      contractTest: '',
      gallTest: '',
    },
    setLoading: (loading: boolean) => set({ loading }),
    init: async () => {


      set({ loading: false })
    },
    setTextState: (text: EditorTextState) => set({ text }),
    submitTest: async (isContract: boolean) => {
      const { text: { contract, contractTest, gall, gallTest } } = get()
      
      if (isContract && (!contract || !contractTest)) {
        return alert('Contract and Test sections cannot be empty')
      } else if (!isContract && (!gall || !gallTest)) {
        return alert('Gall and Test sections cannot be empty')
      }

      const json: any = {}
      if (isContract) {
        json.contract = {
          code: contract,
          test: contractTest
        }
      } else {
        json.gall = {
          code: gall,
          test: gallTest
        }
      }

      // so the `json` will look like:
      // { contract: { code, test } } or
      // { gall: { code, test } }

      // the `mark` needs to be updated
      await api.poke({ app: 'citadel', mark: 'citadel-poke', json })
    }
  }),
  {
    name: 'contractStore'
  }
));

export default useContractStore;
