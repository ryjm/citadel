import React, { useCallback, useEffect } from 'react'
import { Controlled as CodeEditor } from 'react-codemirror2'
import '../../utils/codemirror-hoon'

import './Editors.scss'
require('codemirror/lib/codemirror.css')

export interface CodeMirrorShim {
  setValue: (value: string) => void
  setOption: (option: string, property: any) => void
  focus: () => void
  execCommand: (value: string) => void
  getValue: () => string
  getInputField: () => HTMLInputElement
  getCursor: () => number
  getDoc: () => any
  element: HTMLElement
}

const getPlaceholder = (isContract: boolean, isTest: boolean) => `${isTest ? 'Test' : isContract ? 'Contract' : 'App'}...`

const HOON_CONFIG = {
  name: 'hoon',
  tokenTypeOverrides: {
    header: 'presentation',
    quote: 'quote',
    list1: 'presentation',
    list2: 'presentation',
    list3: 'presentation',
    hr: 'presentation',
    image: 'presentation',
    imageAltText: 'presentation',
    imageMarker: 'presentation',
    formatting: 'presentation',
    linkInline: 'presentation',
    linkEmail: 'presentation',
    linkText: 'presentation',
    linkHref: 'presentation'
  }
}

const defaultOptions = {
  mode: 'hoon',
  lineNumbers: true,
  lineWrapping: true,
  scrollbarStyle: 'native',
  cursorHeight: 0.85,
}

export interface EditorProps {
  editorRef: any
  text: string,
  setText: (inputText: string) => void
  isContract?: boolean
  isTest?: boolean
}

export const Editor = ({
  editorRef,
  text,
  setText,
  isContract = false,
  isTest = false,
}: EditorProps) => {
  useEffect(() => {
    if (!editorRef)
      return
    editorRef.current?.setOption('mode', null)
    editorRef.current?.setOption('placeholder', getPlaceholder(isContract, isTest))
  }, [])

  const options = {
    ...defaultOptions,
    placeholder: getPlaceholder(isContract, isTest),
    extraKeys: {
      'Enter': () => {
        const editor = editorRef?.current
        if (editor) {
          const cursor = editor.getCursor()
          const line = editor.getLine(cursor.line)
          const indent = (line.match(/^\s+/) || [''])[0]
          editor.replaceRange('\n' + indent, cursor)
        }
      },
      'Esc': () => {
        editorRef?.current?.getInputField().blur()
      }
    }
  }

  const textChange = useCallback((editor: CodeMirrorShim, data: any, value: string) => {
    if (text !== '' && value === '') {
      setText(value)
    }
    if (value === text || value === '' || value === ' ')
      return

    setText(value)
  }, [text, setText])

  const onPaste = (cm: CodeMirrorShim, e: ClipboardEvent) => {
    const pastedText = e?.clipboardData?.getData('Text')
    const editor = editorRef?.current
    if (editor && pastedText) {
      const cursor = editor.getCursor()
      editor.replaceRange(pastedText, cursor)
    }
  }

  return (
    <CodeEditor
      className={`editor ${isTest ? 'test' : ''}`}
      value={text}
      options={options}
      onBeforeChange={textChange}
      editorDidMount={(codeEditor: any) => {
        editorRef.current = codeEditor
      }}
      onPaste={onPaste}
      onChange={textChange}
    />
  )
}
