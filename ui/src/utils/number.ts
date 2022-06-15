import { removeDots } from "./format";

export const formatAmount = (amount: number) => new Intl.NumberFormat('en-US').format(amount);

export const addHexDots = (hex: string) => {
  const clearLead = removeDots(hex.replace('0x', '').toLowerCase())
  let result = ''

  for (let i = clearLead.length - 1; i > -1; i--) {
    if (i < clearLead.length - 1 && (clearLead.length - 1 - i) % 4 === 0) {
      result = '.' + result
    }
    result = clearLead[i] + result
  }

  return `0x${result}`
}
