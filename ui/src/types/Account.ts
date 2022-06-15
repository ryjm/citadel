import { removeDots } from "../utils/format"

export interface RawAccount {
  pubkey: string
  privkey: string
  nonces: { [key:string]: number }
}

export interface Account {
  address: string
  rawAddress: string
  privateKey: string
  rawPrivateKey: string
  nonces: { [key:string]: number }
}

export const processAccount = (raw: RawAccount) => ({
  address: removeDots(raw.pubkey),
  rawAddress: raw.pubkey,
  privateKey: removeDots(raw.privkey),
  rawPrivateKey: raw.privkey,
  nonces: raw.nonces,
})
