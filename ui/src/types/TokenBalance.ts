export interface TokenData {
  balance: number
  metadata: string
}

export interface RawTokenBalance {
  lord: string
  data: TokenData
  id: string
  holder: string
  town: number
}

export interface TokenBalance {
  town: number
  riceId: string
  lord: string
  holder: string
  balance: number
  data: TokenData
}

export const processTokenBalance = (raw: RawTokenBalance) => ({
  town: raw.town,
  riceId: raw.id,
  lord: raw.lord,
  holder: raw.holder,
  balance: raw.data.balance,
  data: raw.data
})
