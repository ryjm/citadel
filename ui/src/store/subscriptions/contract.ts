import { GetState, SetState } from "zustand";
import { Molds } from "../../types/Molds";
import { ContractStore } from "../contractStore";

export const handleMoldsUpdate = (get: GetState<ContractStore>, set: SetState<ContractStore>) => (molds: Molds) => {
  console.log('MOLD SUBSCRIPTION:', JSON.stringify(molds))
  // get().setMolds(molds)
}
