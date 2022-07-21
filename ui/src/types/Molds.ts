import { TestAction } from "./TestAction"
import { TestRice } from "./TestGrain"

export const DEV_MOLDS: Molds = {
  actions: {
    give: {
      to: '%id',
      account: ['%unit', '%id'],
      amount: '@ud',
      budget: '@ud'
    },
    take: {
      to: '%id',
      account: ['%unit', '%id'],
      'from-account': '%id',
      amount: '@ud'
    },
    'set-allowance': {
      who: '%id',
      amount: '@ud'
    }
  },
  rice: {
    'token-metadata': {
      name: '@t',
      symbol: '@t',
      decimals: '@ud',
      supply: '@ud',
      cap: ['%unit', '@ud'],
      mintable: '?',
      minters: ['%set', '%id'],
      deployer: '%id',  //  will be 0x0
      salt: '@'
    },
    account: {
      salt: '@',
      'metadata-id': '@ux',
      balance: '@ud',
      allowances: ['%map', { '[sender, %id]': '@ud' }]
    }
  }
}

export interface Molds {
  actions: {
    [key: string]: TestAction
  }
  rice: {
    [key: string]: TestRice
  }
}
