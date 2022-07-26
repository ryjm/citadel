import React, { useCallback, useMemo } from 'react'
import { Droppable } from 'react-beautiful-dnd'
import { FaPen, FaTrash } from 'react-icons/fa';
import Col from '../spacing/Col'
import Row from '../spacing/Row'
import useContractStore from '../../store/contractStore';
import Button from '../form/Button';
import { Test } from '../../types/TestData';
import { TestAction, TestActionValue } from '../../types/TestAction';
import { truncateString } from '../../utils/format';
import Text from '../text/Text';
import { EMPTY_PROJECT } from '../../types/Project';
import { Molds } from '../../types/Molds';

import './Tests.scss'

export const DROPPABLE_DIVIDER = '___'

interface ValuesProps {
  values: TestActionValue
  test?: Test
  actionMold?: TestAction
  indent?: number
}

export const Values = ({ values, actionMold, test, indent = 0 }: ValuesProps) => {
  const indentStyle = { paddingLeft: indent * 8 }

  if (typeof values === 'string') {
    return <div style={indentStyle}>{values.length > 11 ? truncateString(values) : values}</div>
  } else if (Array.isArray(values)) {
    <Col style={indentStyle}>
      {values.map((value) => (
        <Values key={JSON.stringify(value)} values={value} indent={indent + 1} actionMold={actionMold} />
      ))}
    </Col>
  }

  // TODO: check if value is a grain, if so, add a droppable

  return <>
    {Object.keys(values).map((key) => {
      if (actionMold && test && (actionMold?.[key] as any)?.includes('%grain')) {
        console.log('KEY', key)
        return (
          <Row style={{ ...indentStyle, marginTop: 4 }} key={key}>
            <div style={{ width: 115 }}>{key}:</div>
            <Droppable droppableId={`${test.input.cart.batch}___${key}`} style={{ width: '100%' }}>
              {(provided: any) => (
                <Row {...provided.droppableProps} innerRef={provided.innerRef}
                style={{ background: 'lightgray', width: 'calc(100% - 120px)', height: 35, borderRadius: 4, overflow: 'scroll', flexWrap: 'wrap', alignItems: 'flex-start' }}>
                  {(test.input.action[key] as any).map((grain: string) => (
                    <GrainDisplaySmall key={grain} grain={grain} field={key} test={test} />
                  ))}
                  {provided.placeholder}
                </Row>
              )}
            </Droppable>
          </Row>
        )
      }

      return (
        key === 'type' ? null :
        <Row style={{ ...indentStyle, marginTop: 4 }} key={key}>
          <div style={{ width: 100 }}>{key}:</div>
          <Values values={(values as any)[key]} indent={indent + 1} actionMold={actionMold} test={test} />
        </Row>
      )
      })}
  </>
}

const GrainDisplaySmall = ({ grain, field, test }: { grain: string, field?: string, test: Test }) => {
  const { updateTest } = useContractStore()

  const removeGrain = useCallback(() => {
    const newTest = { ...test }

    if (field && newTest.input.action[field] && Array.isArray(newTest.input.action[field])) {
      newTest.input.action[field] = (newTest.input.action[field] as string[]).filter(g => g !== grain)
    } else {
      newTest.input.cart.grains = newTest.input.cart.grains.filter((g) => g !== grain)
    }

    updateTest(newTest)
  }, [field, grain, test, updateTest])

  return (
    <Row style={{ justifyContent: 'space-between', margin: 4, padding: '2px 6px', background: 'white', borderRadius: 4 }}>
      <Text mono style={{ marginRight: 8 }}>ID: {truncateString(grain)}</Text>
      <Button
        onClick={removeGrain}
        variant='unstyled'
        className="delete"
        style={{ fontSize: 20 }}
      >
        &times;
      </Button>
    </Row>
  )
}

interface TestEntryProps extends TestListProps {
  test: Test
  testIndex: number
  molds: Molds
}

export const TestEntry = ({ test, testIndex, editTest, molds }: TestEntryProps) => {
  // need to handle action recursively
  const { removeTest } = useContractStore()

  const testStyle = {
    justifyContent: 'space-between',
    margin: 8,
    padding: 8,
    border: '1px solid black',
    borderRadius: 4,
  }

  return (
    <Col className="action" style={{ ...testStyle, position: 'relative' }}>
        <Col>
          <div style={{ marginBottom: 4 }}>From: {test.input.cart.from}</div>
          <div style={{ marginBottom: 4 }}>Cart Grains: ({test.input.cart.grains?.length})</div>
          <Droppable droppableId={`${test.input.cart.batch}___${test.input.cart.from}`} style={{ width: '100%' }}>
            {(provided: any) => (
              <Row {...provided.droppableProps} innerRef={provided.innerRef}
              style={{ ...provided.droppableProps.style, backgroundColor: 'lightgray', width: '100%', height: 80, borderRadius: 4, overflow: 'scroll', flexWrap: 'wrap', alignItems: 'flex-start' }}>
                {test.input.cart.grains.map(grain => (
                  <GrainDisplaySmall key={grain} grain={grain} test={test} />
                ))}
                {provided.placeholder}
              </Row>
            )}
          </Droppable>
        </Col>
      <Row>
        <Col style={{ width: '100%' }}>
          <h4 style={{ marginBottom: 0 }}>%{test.input.action.type}</h4>
          {/* display the action recursively */}
          <Values indent={1} values={test.input.action} test={test} actionMold={molds.actions[test.input.action.type as string]} />
        </Col>
      </Row>
      <Row style={{ position: 'absolute', top: 4, right: 4, padding: 4 }}>
        <Button
          onClick={() => editTest(test)}
          variant='unstyled'
          className="delete"
          iconOnly
          icon={<FaPen size={14} />}
        />
        <Button
          onClick={() => { if(window.confirm('Are you sure you want to remove this test?')) removeTest(testIndex) }}
          variant='unstyled'
          className="delete"
          style={{ marginLeft: 8 }}
          icon={<FaTrash size={16} />}
          iconOnly
        />
      </Row>
      {/* <Col className="output" style={{ flex: 1 }}>
        {JSON.stringify(test.output)}
      </Col> */}
    </Col>
  )
}

interface TestListProps {
  editTest: (test: Test) => void
  molds: Molds
}

export const TestList = ({ editTest, molds }: TestListProps) => {
  const { projects, currentProject } = useContractStore()
  const project = useMemo(() => projects.find(p => p.title === currentProject), [currentProject, projects])
  const { testData } = useMemo(() => project || EMPTY_PROJECT, [project])

  return (
    <Col className="test-list">
      {testData.tests.map((test, i) => <TestEntry key={test.input.cart.batch} test={test} testIndex={i} editTest={editTest} molds={molds} />)}
    </Col>
  )
}
