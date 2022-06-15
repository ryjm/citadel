export const STATUS_CODES : { [key: number] : string } = {
  0: 'succeeded',
  1: 'no account info',
  2: 'bad signature',
  3: 'incorrect nonce',
  4: 'insufficient budget',
  5: 'contract not found',
  6: 'crash in contract execution',
  7: 'rice validation failed',
  100: 'submitted',
  101: 'received',
  103: 'rejected',
  105: 'sent-to-us',
}

export const getStatus = (status: number) => STATUS_CODES[status] || 'unknown'
