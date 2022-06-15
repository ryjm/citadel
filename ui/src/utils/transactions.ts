import { Transaction } from "../types/Transaction";

interface TransactionGroups {
  pending: Transaction[]
  finished: Transaction[]
  rejected: Transaction[]
}

export const groupTransactions = (txs: Transaction[]) => txs.reduce<TransactionGroups>((acc, cur) => {
  if (cur.status === 100 || cur.status === 101) {
    acc.pending.push(cur)
  } else if (cur.status < 100) {
    acc.finished.push(cur)
  } else if (cur.status === 103) {
    acc.rejected.push(cur)
  }

  return acc
}, { pending: [], finished: [], rejected: [] })
