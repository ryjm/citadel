import { TestAction } from "./TestAction"
import { TestGrain } from "./TestGrain"

export interface Test {
  input: {
    cart: {
      me: string
      from: string
      now: string
      'town-id': string
      owns: string[]
    }
    embryo: {
      action: TestAction
      grains: string[]
    }
  }
  output?: {
    [key: string]: any
  } | undefined
}

export interface TestData {
  tests: Test[]
  grains: TestGrain[]
}
