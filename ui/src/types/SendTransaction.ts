export interface SendTokenPayload {
  from: string
  to: string
  town: number
  amount: number
  destination: string
  token: string
  gasPrice: number
  budget: number
}
