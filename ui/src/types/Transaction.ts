export interface RawTransactions {
  [key: string]: Transaction
}

export interface Transaction {
  hash: string
  from: string
  to: string
  town: number
  destination?: string
  rate: number
  budget: number
  nonce: number
  status: number
  created: Date
  modified: Date
}
