import React, { useCallback, useMemo } from 'react'
import { Droppable } from 'react-beautiful-dnd'
import { FaPen, FaTrash } from 'react-icons/fa';
import Col from '../spacing/Col'
import Row from '../spacing/Row'
import useContractStore from '../../store/contractStore';
import Button from '../form/Button';
import { Test } from '../../types/TestData';
import { TestActionValue } from '../../types/TestAction';
import { truncateString } from '../../utils/format';
import Text from '../text/Text';
import { EMPTY_PROJECT } from '../../types/Project';

import './Tests.scss'

export const DROPPABLE_DIVIDER = '___'

interface ValuesProps {
  values: TestActionValue
  indent?: number
}

export const Values = ({ values, indent = 0 }: ValuesProps) => {
  const indentStyle = { paddingLeft: indent * 8 }

  if (typeof values === 'string') {
    return <div style={indentStyle}>{values.length > 11 ? truncateString(values) : values}</div>
  } else if (Array.isArray(values)) {
    <Col style={indentStyle}>
      {values.map((value) => (
        <Values key={JSON.stringify(value)} values={value} indent={indent + 1} />
      ))}
    </Col>
  }

  return <>
    {Object.keys(values).map((key) => (
      key === 'type' ? null :
      <Row style={indentStyle} key={key}>
        <div>{key}:</div>
        <Values values={(values as any)[key]} indent={indent + 1} />
      </Row>
    ))}
  </>
}

const GrainDisplaySmall = ({ grain, type, test }: { grain: string, type: 'own' | 'action', test: Test }) => {
  const { updateTest } = useContractStore()

  const removeGrain = useCallback(() => {
    const newTest = { ...test }

    if (type === 'own') {
      newTest.input.cart.owns = newTest.input.cart.owns.filter((g) => g !== grain)
    } else {
      newTest.input.embryo.grains = newTest.input.embryo.grains.filter((g) => g !== grain)
    }

    updateTest(newTest)
  }, [type, grain, test, updateTest])

  return (
    <Row style={{ justifyContent: 'space-between', margin: 4, padding: 4, background: 'white', borderRadius: 4 }}>
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
}

export const TestEntry = ({ test, testIndex, editTest }: TestEntryProps) => {
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
          <div>From: {test.input.cart.from}</div>
          <div>Owned Grains: ({test.input.cart.owns.length})</div>
          <Droppable droppableId={`${test.input.cart.now}___${test.input.cart.from}`} style={{ width: '100%' }}>
            {(provided: any) => (
              <Row {...provided.droppableProps} innerRef={provided.innerRef}
              style={{ ...provided.droppableProps.style, backgroundColor: 'lightgray', width: '100%', height: 80, borderRadius: 4, overflow: 'scroll', flexWrap: 'wrap', alignItems: 'flex-start' }}>
                {test.input.cart.owns.map(grain => (
                  <GrainDisplaySmall key={grain} grain={grain} type="own" test={test} />
                ))}
                {provided.placeholder}
              </Row>
            )}
          </Droppable>
        </Col>
      <Row>
        <Col style={{ width: '40%' }}>
          <h4 style={{ marginBottom: 0 }}>%{test.input.embryo.action.type}</h4>
          {/* display the action recursively */}
          <Values indent={1} values={test.input.embryo.action} />
        </Col>
        <Col style={{ width: '60%', alignSelf: 'flex-end' }}>
          <div>Action Grains: ({test.input.embryo.grains.length})</div>
          <Droppable droppableId={`${test.input.cart.now}___${test.input.embryo.action.type}`} style={{ width: '100%' }}>
            {(provided: any) => (
              <Row {...provided.droppableProps} innerRef={provided.innerRef}
              style={{ background: 'lightgray', width: '100%', height: 80, borderRadius: 4, overflow: 'scroll', flexWrap: 'wrap', alignItems: 'flex-start' }}>
                {test.input.embryo.grains.map(grain => (
                  <GrainDisplaySmall key={grain} grain={grain} type="action" test={test} />
                ))}
                {provided.placeholder}
              </Row>
            )}
          </Droppable>
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
}

export const TestList = ({ editTest }: TestListProps) => {
  const { projects, currentProject } = useContractStore()
  const project = useMemo(() => projects.find(p => p.title === currentProject), [currentProject, projects])
  const { testData } = useMemo(() => project || EMPTY_PROJECT, [project])

  return (
    <Col className="test-list">
      {testData.tests.map((test, i) => <TestEntry key={test.input.cart.now} test={test} testIndex={i} editTest={editTest} />)}
    </Col>
  )
}
