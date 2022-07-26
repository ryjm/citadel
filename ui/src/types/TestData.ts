import { TestAction } from "./TestAction"
import { TestGrain } from "./TestGrain"

export interface Test {
  input: {
    cart: {
      me: string
      from: string
      batch: number
      'town-id': string
      grains: string[]
    }
    action: TestAction
  }
  output?: {
    [key: string]: any
  } | undefined
}

export interface TestData {
  tests: Test[]
  grains: TestGrain[]
}
