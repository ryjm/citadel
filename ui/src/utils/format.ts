import { TypeAnnotation } from "./form"

export const removeDots = (str: string) => str.replace(/\./g, '')

export const formatHash = (hash: string) => `${removeDots(hash).slice(0, 10)}...${removeDots(hash).slice(-8)}`

export const truncateString = (str: string) => `${removeDots(str).slice(0, 4)}...${removeDots(str).slice(-4)}`

// export const typeFormats = {
//   '@': removeDots,
//   '@da': ,
//   '@p': ,
//   '@rs': ,
//   '@t': ,
//   '@ub': ,
//   '@ud': ,
//   '@ux': ,
//   '?': ,
// }

export const formatType = (type: TypeAnnotation, value: string) => {
  
}
