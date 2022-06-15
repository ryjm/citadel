export const removeDots = (str: string) => str.replace(/\./g, '')

export const formatHash = (hash: string) => `${removeDots(hash).slice(0, 10)}...${removeDots(hash).slice(-8)}`
