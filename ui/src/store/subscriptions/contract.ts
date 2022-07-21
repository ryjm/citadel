import { GetState, SetState } from "zustand";
import { Assets } from "../../types/Assets";
import { Molds } from "../../types/Molds";
import { processTokenBalance, RawTokenBalance } from "../../types/TokenBalance";
import { Transaction } from "../../types/Transaction";
import { removeDots } from "../../utils/format";
import { ContractStore } from "../contractStore";

export const handleMoldsUpdate = (get: GetState<ContractStore>, set: SetState<ContractStore>) => (molds: Molds) => {
  console.log('MOLD SUBSCRIPTION:', JSON.stringify(molds))
  get().setMolds(molds)
}
