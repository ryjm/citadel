import React, { FormEvent, useCallback, useMemo, useRef } from 'react'
import { useLocation } from 'react-router-dom'
import { FaPlay, FaBug, FaArrowUp, FaCode } from 'react-icons/fa';
import 'codemirror/lib/codemirror.css'
import 'codemirror/theme/material.css'
import 'codemirror/addon/display/placeholder'
import Iframe from 'react-iframe';
import Button from '../components/form/Button'
import Form from '../components/form/Form'
import Col from '../components/spacing/Col'
import Container from '../components/spacing/Container'
import Row from '../components/spacing/Row'
import { CodeMirrorShim, Editor } from '../components/editor/Editors'
import useContractStore from '../store/contractStore'

import './EditorView.scss'
import { isMobileCheck } from '../utils/dimensions';

const WEBTERM_PATH = '/apps/webterm'

type SelectedEditor = 'contract' | 'gall' | 'contractTest' | 'gallTest'

const EditorView = () => {
  const location = useLocation()
  const contractEditor = useRef<CodeMirrorShim>()
  const gallEditor = useRef<CodeMirrorShim>()
  const contractTestEditor = useRef<CodeMirrorShim>()
  const gallTestEditor = useRef<CodeMirrorShim>()
  const { text, setLoading, setTextState, submitTest } = useContractStore()

  const isContract = useMemo(() => location.pathname === '/', [location])
  const selected = useMemo(() => isContract ? 'contract' : 'gall', [isContract])
  const selectedTest = useMemo(() => `${selected}Test` as SelectedEditor, [selected])

  const submit = useCallback(async (e: FormEvent) => {
    e.preventDefault()

    setLoading(true)
    await submitTest(isContract)
    setLoading(false)
  }, [isContract, submitTest, setLoading])
  
  const setText = useCallback((editor: SelectedEditor) => (inputText: string) => {
    const newText = { ...text }
    newText[editor] = inputText
    setTextState(newText)
  }, [text, setTextState])

  const buttonProps = { style: { padding: 0, marginRight: 24 }, variant: 'unstyled', fontSize: 14 }
  const isMobile = isMobileCheck()

  return (
    <Container className='editor-view'>
      {/* <h2>Test & Deploy {isContract ? 'Contract' : 'Gall App'}</h2> */}
      <Form onSubmit={submit} style={{ padding: 0, border: '1px solid lightgray', height: '100%', background: 'white' }}>
        <Row style={{ height: 24, background: 'lightgray', padding: '4px 16px', justifyContent: 'space-between' }}>
          <Row>
            <Button iconOnly={isMobile} type="submit" {...buttonProps} icon={<FaPlay style={{ marginRight: 8 }} size={14} />}>
              Run
            </Button>
            <Button iconOnly={isMobile} {...buttonProps} icon={<FaBug style={{ marginRight: 8 }} size={14} />}>
              Debug
            </Button>
            <Button iconOnly={isMobile} {...buttonProps} icon={<FaArrowUp style={{ marginRight: 8 }} size={14} />}>
              Deploy
            </Button>
          </Row>
          <Button iconOnly={isMobile} {...buttonProps} style={{ ...buttonProps.style, margin: 0 }} icon={<FaCode size={14} style={{ marginRight: 8 }} />}>
            Format
          </Button>
        </Row>
        <Row style={{ height: 'calc(100% - 32px)', width: 'calc(100% - 2px)', flexDirection: isMobile ? 'column' : 'row' }}>
          <Col style={{ height: isMobile ? 600 : '100%', width: isMobile ? '100%' : '60%', borderBottom: isMobile ? '1px solid lightgray' : undefined }}>
            <Editor
              editorRef={isContract ? contractEditor : gallEditor}
              text={text[selected]}
              setText={setText(selected)}
              isContract={isContract}
            />
          </Col>
          <Col style={{ height: isMobile ? 400 : '100%', width: isMobile ? '100%' : '40%' }}>
            <Editor
              editorRef={isContract ? contractTestEditor : gallTestEditor}
              text={text[selectedTest]}
              setText={setText(selectedTest)}
              isContract={isContract}
              isTest
            />
            <Iframe url={WEBTERM_PATH} height={isMobile? '40%' : '100%'} width='100%' />
          </Col>
        </Row>
      </Form>
    </Container>
  )
}

export default EditorView

// import Iframe from 'react-iframe'
// import { Resizable, ResizeCallback } from 're-resizable'
// import create from 'zustand'
// import { persist } from 'zustand/middleware'
// const termUrl = '/apps/webterm'

// const windowSettings = create(persist((set, get) => ({
//   termRatio: .66
// }), {
//   name: 'citadel-settings'
// }))

// const Resizer = () => (
//   <div className='absolute right-0 top-0 px-2 -mr-2'>
//     <div className='flex items-center h-screen bg-gray-200'>
//       <SelectorIcon className='h-6 w-6 text-gray-800 rotate-90' />
//     </div>
//   </div>
// )
