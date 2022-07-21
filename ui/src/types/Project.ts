import { Molds } from "./Molds"
import { TestAction } from "./TestAction"
import { TestData } from "./TestData"
import { TestRice } from "./TestGrain"

export const EMPTY_PROJECT = { testData: { tests: [], grains: [] }, molds: { rice: {} as { [key: string]: TestRice }, actions: {} as { [key: string]: TestAction } } }

export interface EditorTextState {
  [key: string]: string
}

export interface Project {
  title: string
  text: EditorTextState
  testData: TestData
  molds: Molds
}
