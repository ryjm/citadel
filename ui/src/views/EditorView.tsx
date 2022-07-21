<<<<<<< Updated upstream
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
=======
import React, { FormEvent, useCallback, useMemo, useRef, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom';
import 'codemirror/lib/codemirror.css'
import 'codemirror/theme/material.css'
import 'codemirror/addon/display/placeholder'
import Button, { ButtonVariant } from '../components/form/Button'
import Form from '../components/form/Form'
import Col from '../components/spacing/Col'
import Row from '../components/spacing/Row'
import { CodeMirrorShim, Editor } from '../components/editor/Editors'
import useContractStore from '../store/contractStore'
import { isMobileCheck } from '../utils/dimensions';
import { TestView } from '../components/tests/Tests';

import './EditorView.scss'
import Link from '../components/nav/Link';
import NewProjectView from './NewProjectView';

type SelectedEditor = 'contract_main' | 'contract_types' | 'contract_tests' | 'gall_app' | 'gall_sur' | 'gall_lib'
type SubContract = 'main' | 'types' | 'tests'
const SUB_CONTRACT: SubContract[] = ['main', 'types', 'tests']
type SubGall = 'app' | 'sur' | 'lib'
const SUB_GALL: SubGall[] = ['app', 'sur', 'lib']

const EditorView = ({ hide = false }: { hide?: boolean }) => {
  // const location = useLocation()
  // const isContract = useMemo(() => location.pathname === '/', [location])
  const contract_mainEditor = useRef<CodeMirrorShim>()
  const contract_typesEditor = useRef<CodeMirrorShim>()
  const gall_appEditor = useRef<CodeMirrorShim>()
  const gall_surEditor = useRef<CodeMirrorShim>()
  const gall_libEditor = useRef<CodeMirrorShim>()
  const { projects, currentProject, route, setLoading, setTextState, submitTest, saveFiles } = useContractStore()
  const subContract = route.subRoute

  const refMap = { contract_mainEditor, contract_typesEditor, contract_testsEditor: null, gall_appEditor, gall_surEditor, gall_libEditor }
  const editors: SelectedEditor[] = ['contract_main', 'contract_types', 'contract_tests', 'gall_app', 'gall_sur', 'gall_lib']

  const project = useMemo(() => projects.find(p => p.title === currentProject), [currentProject, projects])
  const text = useMemo(() => project?.text || {}, [project])

  const [isContract, setIsContract] = useState(true)
  const [subGall, setSubGall] = useState<SubGall>('app')
  const selected = useMemo(() => `${isContract ? `contract_${subContract}` : `gall_${subGall}`}` as SelectedEditor, [isContract, subContract, subGall])
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
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
=======
  const isMobile = isMobileCheck()

  return (
    <Form className="editor-view" onSubmit={submit} style={{ visibility: hide ? 'hidden' : 'visible', padding: 0, height: '100%', width: '100%', background: 'white', position: 'absolute' }}>
      <Row style={{ justifyContent: 'space-between', background: 'lightgray' }}>
        <Col>
          <Row>
              {SUB_CONTRACT.map((value, i, arr) => (
                <Link key={value} className={`tab ${subContract === value ? 'selected' : ''}`} href={`/contract/${value}`}>{value}</Link>
              ))}
          </Row>
        </Col>
        {/* <Row style={{ padding: '4px' }}>
          <Button iconOnly={isMobile} onClick={saveFiles} {...buttonProps} icon={<FaSave style={{ marginRight: 8 }} size={14} />}>
            Save
          </Button>
          <Button iconOnly={isMobile} type="submit" {...buttonProps} icon={<FaPlay style={{ marginRight: 8 }} size={14} />}>
            Test
          </Button>
          <Button iconOnly={isMobile} {...buttonProps} icon={<FaFileDownload style={{ marginRight: 8 }} size={14} />}>
            Export
          </Button>
        </Row> */}
      </Row>
      <Row style={{ height: 'calc(100% - 28px)', width: 'calc(100% - 2px)' }}>
        <Col style={{ height: '100%', width: '100%', borderBottom: isMobile ? '1px solid lightgray' : undefined }}>
          {editors.map((ed) => (
            <Editor
              key={ed}
              editorRef={refMap[`${ed}Editor`] || { current: undefined }}
              text={text[ed]}
              setText={setText(ed)}
              isContract={isContract}
              selected={ed !== 'contract_tests' && ed === selected}
            />
          ))}
          {selected === 'contract_tests' && (
            <TestView />
          )}
        </Col>
        {/* <Col style={{ height: isMobile ? 400 : '100%', width: isMobile ? '100%' : '40%' }}>
          <Iframe url={WEBTERM_PATH} height={isMobile? 400 : '100%'} width='100%' />
        </Col> */}
      </Row>
    </Form>
>>>>>>> Stashed changes
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
