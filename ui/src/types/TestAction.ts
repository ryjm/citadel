import { UqbarType } from "./UqbarType"

export type TestActionType = UqbarType | TestActionValue[] | { [key: string]: TestActionValue }

export type TestActionValue = string | TestActionValue[] | { [key: string]: TestActionValue }

export interface TestAction {
  [key: string]: TestActionValue
}
