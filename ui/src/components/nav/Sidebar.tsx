import React, { useCallback, useMemo, useState } from 'react'
import { FaRegPlusSquare, FaRegMinusSquare, FaSave, FaDownload } from 'react-icons/fa';
import useContractStore from '../../store/contractStore'
import Button from '../form/Button';
import Input from '../form/Input';
import { Select } from '../form/Select';
import Modal from '../popups/Modal';
import Col from '../spacing/Col'
import Row from '../spacing/Row'
import Text from '../text/Text'
import Link from './Link';

export const Sidebar = () => {
  const { projects, currentProject, currentApp, openApps, route, setRoute, saveFiles, setCurrentProject, addApp, setCurrentApp, removeApp } = useContractStore()
  const [showAppModal, setShowAppModal] = useState(false)
  const [appToAdd, setAppToAdd] = useState('')
  const [contractExpanded, setContractExpanded] = useState(true)

  const project = useMemo(() => projects.find(() => projects.find(({ title }) => title === currentProject)), [projects, currentProject])

  const buttonStyle = {
    marginLeft: 6,
    padding: 2,
  }

  const buttons = [
    [<FaRegPlusSquare />, () => setRoute({ route: 'project', subRoute: 'new' })],
    [<FaSave />, () => saveFiles()],
    [<FaDownload />, () => null],
  ]

  const selectProject = useCallback((p: string) => {
    setCurrentProject(p)
    setRoute({ route: 'contract', subRoute: 'main' })
  }, [setCurrentProject, setRoute])

  const openApp = useCallback(() => {
    // TODO: check if app is valid
    if (!openApps.includes(appToAdd)) {
      addApp(appToAdd)
    } else {
      setCurrentApp(appToAdd)
    }
    setRoute({ route: 'app', subRoute: appToAdd })
    setShowAppModal(false)
    setAppToAdd('')
  }, [appToAdd, addApp, setRoute, openApps, setCurrentApp])

  const setApp = useCallback((app: string) => {
    setCurrentApp(app)
    setRoute({ route: 'app', subRoute: app })
  }, [setCurrentApp, setRoute])

  const isContractRoute = route.route === 'contract'

  return (
    <Col style={{ height: '100%', width: 'calc(100% - 1px)', maxWidth: 239, minWidth: 209, borderRight: '1px solid black' }}>
      <Col style={{ width: '100%', height: '60%', overflow: 'scroll' }}>
        <Text style={{ fontSize: 16, fontWeight: 600, padding: '16px 24px' }}>PROJECT EXPLORER</Text>
        <Row style={{ padding: '8px 12px' }}>
          <div style={{ fontSize: 14, padding: 2, marginRight: 6 }}>Projects</div>
          {buttons.map(([icon, onClick]: any, i: number) => (
            <Button key={i} style={buttonStyle} variant="unstyled" onClick={onClick} iconOnly icon={icon} />
          ))}
        </Row>
        {projects.length > 0 && (
          <Select style={{ margin: '0 12px 16px', fontSize: 14, width: 'calc(100% - 24px)', backgroundColor: 'rgba(0,0,0,0.08)', border: 'none' }}
            value={currentProject} onChange={(e) => selectProject(e.target.value)}>
            {projects.map(({ title }) => (
              <option key={title} value={title}>{title}</option>
            ))}
          </Select>
        )}
        {project && (
          <Col style={{ padding: '0px 4px', fontSize: 14 }}>
            <Row style={{ padding: 2, marginBottom: 2, cursor: 'pointer' }} onClick={() => setContractExpanded(!contractExpanded)}>
              <Button style={buttonStyle} variant="unstyled" iconOnly icon={contractExpanded ? <FaRegMinusSquare size={12} /> : <FaRegPlusSquare size={12} />} />
              <Text style={{ marginLeft: 4 }}>Contract</Text>
            </Row>
            {contractExpanded && (
              <Col style={{ paddingLeft: 28 }}>
                <Link underline={isContractRoute && route.subRoute === 'main'} href='/contract/main' style={{ padding: 2 }}>- main</Link>
                <Link underline={isContractRoute && route.subRoute === 'types'} href='/contract/types' style={{ padding: 2 }}>- types</Link>
                <Link underline={isContractRoute && route.subRoute === 'tests'} href='/contract/tests' style={{ padding: 2 }}>- tests</Link>
              </Col>
            )}
          </Col>
        )}
      </Col>
      <Col style={{ width: '100%', height: 'calc(40% - 1px)', borderTop: '1px solid black', overflow: 'scroll' }}>
        <Row style={{ padding: '8px 12px' }}>
          <div style={{ fontSize: 14, padding: 2, marginRight: 0 }}>Apps</div>
          <Button style={buttonStyle} variant="unstyled" onClick={() => setShowAppModal(true)} iconOnly icon={<FaRegPlusSquare />} />
        </Row>
        <Col>
          {openApps.map(app => (
            <Row key={app} style={{ marginLeft: 14, cursor: 'pointer' }} onClick={() => setApp(app)}>
              <Text style={{ fontSize: 14, textDecoration: app === currentApp ? 'underline' : undefined }}>{app}</Text>
              <Button
                onClick={(e) => {
                  e.stopPropagation()
                  removeApp(app)
                }}
                variant='unstyled'
                className="delete"
                style={{ fontSize: 20, marginLeft: 6, marginTop: 4 }}
              >
                &times;
              </Button>
            </Row>
          ))}
        </Col>
      </Col>
      <Modal show={showAppModal} hide={() => {setShowAppModal(false)}}>
        <h3 style={{ marginTop: 0 }}>Enter App URL (i.e. "webterm"):</h3>
        <Input onChange={(e) => setAppToAdd(e.target.value)} value={appToAdd} placeholder='app url' />
        <Button style={{ margin: '16px auto 0' }} variant='dark' onClick={openApp}>Open App</Button>
      </Modal>
    </Col>
  )
}
