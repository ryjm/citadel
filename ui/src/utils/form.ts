import { TestAction, TestActionValue } from "../types/TestAction"
import { Test } from "../types/TestData"
import { TestGrain, TestRice, TestRiceValue } from "../types/TestGrain"
import { UqbarType } from "../types/UqbarType"
import { removeDots } from "./format"

const GRAIN_FORM_VALUES_COMMON: { [key: string]: any } = {
  id: '%id',
  lord: '%id',
  holder: '%id',
  'town-id': '%id',
}

export const TEST_FORM_VALUES_COMMON: { [key: string]: any } = {
  me: '%id',
  id: '%id',
  from: '(id, nonce)',
  'town-id': '%id'
}

const findValue = (obj: { [key: string]: any }, key: string) : string => {
  return Object.keys(obj).reduce((acc: string, cur: string) => {
    if (acc) {
      return acc
    } else if (cur === key) {
      return obj[cur]
    } else if (typeof obj[cur] === 'object') {
      return acc || findValue(obj[cur], key)
    }

    return acc
  }, '')
}

export interface FormField { value: string, type: UqbarType }

export const generateFormValues = (type: 'grain' | 'test', data: TestRice | TestAction, edit?: Test | TestGrain): { [key: string]: FormField } => {
  // TODO: populate the fields with the values from "edit" arg
  const allFields = type === 'grain' ? { ...GRAIN_FORM_VALUES_COMMON, ...data } : { ...TEST_FORM_VALUES_COMMON, ...data }
  Object.keys(allFields).forEach((key) => allFields[key] = { type: allFields[key], value: edit ? findValue(edit, key) : allFields[key].includes('%grain') ? [] : '' })
  return allFields
}

export const testFromForm = (testFormValues: { [key: string]: FormField }, actionType: string) => ({
  input: {
    cart: {
      me: testFormValues.me.value,
      from: testFormValues.from.value,
      batch: 0,
      'town-id': testFormValues['town-id'].value,
      grains: []
    },
    action: Object.keys(testFormValues).reduce((acc, key) => {
      if (!Object.keys(TEST_FORM_VALUES_COMMON).includes(key)) {
        acc[key] = testFormValues[key].value as TestActionValue
      }
      return acc
    }, { type: actionType } as TestAction),
  }
})

export const grainFromForm = (testGrainValues: { [key: string]: FormField }, grainType: string) => ({
  id: testGrainValues.id.value,
  lord: testGrainValues.lord.value,
  holder: testGrainValues.holder.value,
  'town-id': testGrainValues['town-id'].value,
  type: grainType,
  rice: Object.keys(testGrainValues).reduce((acc, key) => {
    if (!Object.keys(GRAIN_FORM_VALUES_COMMON).includes(key)) {
      acc[key] = testGrainValues[key].value as TestRiceValue
    }
    return acc
  }, {} as TestRice),
})

const HEX_REGEX = /^(0x)?[0-9A-Fa-f]+$/i
const BIN_REGEX = /^(0b)?[0-1]+$/i

const isValidHex = (str: string) => HEX_REGEX.test(str)

export type TypeAnnotation = UqbarType | { [key: string]: TypeAnnotation } | UqbarType[] | (UqbarType | { [key: string]: TypeAnnotation })[]

export const validateWithType = (type: UqbarType, value: string) => {
  switch (type) {
    case '%id':
      return isValidHex(value) && value.length <= 46
    case '@': // @	Empty aura	100	(displays as @ud)
      return !isNaN(Number(value))
    case '@da': // @da	Date (absolute)	~2022.2.8..16.48.20..b53a	Epoch calculated from 292 billion B.C.
      return true
    case '@p': // @p	Ship name	~zod
      return true
    case '@rs': // @rs	Number with fractional part	.3.1415	Note the preceding . dot.
      return !isNaN(Number(value.slice(1)))
    case '@t': // @t	Text (“cord”)	'hello'	One of Urbit's several text types; only UTF-8 values are valid.
      return true
    case '@ub': // @ub	Binary value	0b1100.0101	
      return BIN_REGEX.test(value.replace(/\./gi, ''))
    case '@ud': // @ud	Decimal value	100.000	Note that German-style thousands separator is used, . dot.
      return !isNaN(Number(value.replace(/\./ig, '').replace(/,/gi, '.')))
    case '@ux': // @ux	Hexadecimal value	0x1f.3c4b
      return HEX_REGEX.test(value.replace(/\./gi, ''))
    case '?': // boolean
      return value === 'true' || value === 'false'
    case '%unit': // maybe
      return false
    case '%set': // set
      return false
    case '%map': // map
      return false
    default:
      return true
  }
}

export const validate = (type: TypeAnnotation) => (value?: string): boolean => {
  if (typeof type === 'string' && type.includes('%grain')) {
    // grains will be handled with drag-and-drop
    return true
  }

  if (Array.isArray(type)) {
    const [modifier, uType] = type
     if (modifier === '%unit') {
      if (!value) {
        return true
      } else {
        return validate(uType)(value)
      }
    } else if (!value) {
      return false
    } else if (modifier === '%set') {
      if (value === '[]') {
        return true
      }
      return value.replace('[', '').replace(']', '').replace(/'/g, '').split(',').reduce((acc: boolean, cur) => acc && validate(uType)(cur.trim()), true)
    } else if (modifier === '%map') {
      return true // TODO: %map validation
    }
  } else if (typeof type === 'object') {
    return Object.keys(type).reduce((acc: boolean, cur: string): boolean => acc && validate(type[cur])(value), true)
  } else if (value) {
    return validateWithType(type, value)
  }

  return false
}

export const validateFormValues = (formValues: { [key: string]: FormField }) =>
  Object.keys(formValues).reduce((acc, key) => {
    const { value, type } = formValues[key]
    const isValid = Array.isArray(value) || validate(type)(removeDots(value))

    return acc || (isValid ? '' : `Form Error: ${key} must be of type ${type}`)
  }, '')
