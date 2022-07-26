import create from "zustand"
import { persist } from "zustand/middleware"
import api from "../api";
import { initialMain } from "../code-text/contract/fungible/main";
import { initialTests } from "../code-text/contract/fungible/tests";
import { initialTypes } from "../code-text/contract/fungible/types";
import { initialApp } from "../code-text/gall/app";
import { initialLib } from "../code-text/gall/lib";
import { initialSur } from "../code-text/gall/sur";
import { fungibleTokenTestData } from "../code-text/test-data/fungible";
import { DEV_MOLDS, Molds } from "../types/Molds";
import { EditorTextState, Project } from "../types/Project";
import { Test } from "../types/TestData";
import { TestGrain } from "../types/TestGrain";
import { handleMoldsUpdate } from "./subscriptions/contract";
import { createSubscription } from "./subscriptions/createSubscription";

export interface Route { route: string, subRoute?: string }

export interface ContractStore {
  loading: boolean
  currentProject: string
  projects: Project[]
  openApps: string[]
  currentApp: string
  route: Route
  setRoute: (route: Route) => void
  setLoading: (loading: boolean) => void
  init: () => Promise<void>
  createProject: (options: { [key: string]: string }) => Promise<void>
  setCurrentProject: (currentProject: string) => void
  addApp: (app: string) => void
  setCurrentApp: (currentApp: string) => void
  removeApp: (app: string) => void
  setMolds: (molds: Molds) => void
  setTextState: (text: EditorTextState) => void
  saveFiles: () => Promise<void>
  submitTest: (isContract: boolean) => Promise<void>
  addTest: (test: Test) => void
  updateTest: (test: Test) => void
  removeTest: (index: number) => void
  addGrain: (grain: TestGrain) => void
  updateGrain: (grain: TestGrain) => void
  setGrains: (grains: TestGrain[]) => void
  removeGrain: (grain: number | TestGrain) => void
}

const useContractStore = create<ContractStore>(persist<ContractStore>(
  (set, get) => ({
    loading: true,
    currentProject: '',
    projects: [],
    openApps: [],
    currentApp: '',
    route: { route: 'project', subRoute: 'new' },
    setRoute: (route: Route) => set({ route }),
    setLoading: (loading: boolean) => set({ loading }),
    init: async () => {
      api.subscribe(createSubscription('citadel', '/citadel/types', handleMoldsUpdate(get, set)))

      if (get().projects.length > 0) {
        set({ route: { route: 'contract', subRoute: 'main' } })
      }

      set({ loading: false })
    },
    createProject: async (options: { [key: string]: string }) => {
      const { projects } = get()
      
      // TODO: base the values off of the selections
      // type CreationStep = 'project' | 'token' |  'template'
      // export type CreationOption = 'contract' | 'gall' | 'fungible' | 'nft' | 'issue' | 'wrapper'
      const newProject = {
        title: options.title,
        testData: fungibleTokenTestData,
        molds: DEV_MOLDS,
        text: {
          contract_main: initialMain,
          contract_types: initialTypes,
          // contract_tests: initialTests,
          // gall_app: initialApp,
          // gall_sur: initialSur,
          // gall_lib: initialLib,
        }
      }

      set({ projects: projects.concat([newProject]), currentProject: options.title })
    },
    setCurrentProject: (currentProject: string) => set({ currentProject }),
    addApp: (app: string) => set({ openApps: get().openApps.concat([app]), currentApp: app }),
    setCurrentApp: (currentApp: string) => set({ currentApp }),
    removeApp: (app: string) => {
      const { openApps, currentApp } = get()
      set({ openApps: openApps.filter(a => a !== app), currentApp: currentApp === app ? openApps[0] || '' : currentApp })
    },
    setMolds: (molds: Molds) => {
      const { projects, currentProject } = get()
      set({ projects: projects.map(p => p.title === currentProject ? { ...p, molds } : p) })
    },
    setTextState: (text: EditorTextState) => set({ projects: get().projects.map((p) => p.title === get().currentProject ? { ...p, text } : p) }),
    saveFiles: async () => {
      console.log(1, 'saving')
      const { text } = get().projects.find(p => p.title === get().currentProject) || { text: null }
      console.log(2, text)
      if (text !== null) {
      await api.poke({
          app: 'citadel',
          mark: 'citadel-action',
          json: {
            // {\"save\":\{\"gall\":\{\"groms\":null,\"charter\":\"\"}}}
            save: {
              arena: 'contract',
              deeds: [{dir: 'lib', scroll: {text: 'libtext', project: 'project-name', path: '/lib/hoon'}}],
              charter: text.contract_main
            }
          }
        })
      }
    },
    submitTest: async (isContract: boolean) => {
      // const { text: { contract, contractTest, gall, gallTest } } = get()
      
      // if (isContract && (!contract || !contractTest)) {
      //   return alert('Contract and Test sections cannot be empty')
      // } else if (!isContract && (!gall || !gallTest)) {
      //   return alert('Gall and Test sections cannot be empty')
      // }

      // const json: any = {}
      // if (isContract) {
      //   json.contract = {
      //     code: contract,
      //     test: contractTest
      //   }
      // } else {
      //   json.gall = {
      //     code: gall,
      //     test: gallTest
      //   }
      // }

      // so the `json` will look like:
      // { contract: { code, test } } or
      // { gall: { code, test } }

      // the `mark` needs to be updated
      await api.poke({ app: 'citadel', mark: 'citadel-poke', json: {} })
    },
    addTest: (test: Test) => {
      const { projects, currentProject } = get()
      set({ projects: projects.map(p => p.title === currentProject ? { ...p, testData: { ...p.testData, tests: p.testData.tests.concat([test]) } } : p) })
    },
    updateTest: (newTest: Test) => {
      const { projects, currentProject } = get()
      // TODO: change the unique identifier for test to id
      set({ projects: projects.map(p => p.title === currentProject ? { ...p, testData: { ...p.testData, tests: p.testData.tests.map((test) => test.input.cart.batch === newTest.input.cart.batch ? newTest : test) } } : p) })
    },
    removeTest: (index: number) => {
      const { projects, currentProject } = get()
      set({ projects: projects.map(p => p.title === currentProject ? { ...p, testData: { ...p.testData, tests: p.testData.tests.filter((_, i) => i !== index) } } : p) })
    },
    addGrain: (grain: TestGrain) => {
      const { projects, currentProject } = get()
      set({ projects: projects.map(p => p.title === currentProject ? { ...p, testData: { ...p.testData, grains: p.testData.grains.concat([grain]) } } : p) })
    },
    updateGrain: (newGrain: TestGrain) => {
      const { projects, currentProject } = get()
      set({ projects: projects.map(p => p.title === currentProject ? { ...p, testData: { ...p.testData, grains: p.testData.grains.map((g) => g.id === newGrain.id ? newGrain : g) } } : p) })
    },
    setGrains: (grains: TestGrain[]) => {
      const { projects, currentProject } = get()
      set({ projects: projects.map(p => p.title === currentProject ? { ...p, testData: { ...p.testData, grains } } : p) })
    },
    removeGrain: (grain: number | TestGrain) => {
      const { projects, currentProject } = get()
      if (typeof grain === 'number') {
        set({ projects: projects.map(p => p.title === currentProject ? { ...p, testData: { ...p.testData, grains: p.testData.grains.filter((_, i) => i !== grain) } } : p) })
      } else {
        set({ projects: projects.map(p => p.title === currentProject ? { ...p, testData: { ...p.testData, grains: p.testData.grains.filter((g) => g.id !== grain.id) } } : p) })
      }
    },
  }),
  {
    name: 'contractStore'
  }
));

export default useContractStore;
