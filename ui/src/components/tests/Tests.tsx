import React, { useCallback, useMemo, useState } from 'react'
import Iframe from 'react-iframe';
import { DragDropContext } from 'react-beautiful-dnd';
import { isMobileCheck } from '../../utils/dimensions'
import Col from '../spacing/Col'
import Row from '../spacing/Row'
import useContractStore from '../../store/contractStore';
import Modal from '../popups/Modal';
import Button from '../form/Button';
import Input from '../form/Input';
import { FormField, generateFormValues, grainFromForm, testFromForm, validateFormValues } from '../../utils/form';
import { Select } from '../form/Select';
import { DROPPABLE_DIVIDER, TestList } from './TestList';
import { GrainList } from './GrainList';
import { TestGrain, } from '../../types/TestGrain';
import { Test } from '../../types/TestData';
import { EMPTY_PROJECT } from '../../types/Project';

import './Tests.scss'

const WEBTERM_PATH = '/apps/webterm'

export interface TestViewProps {}

export const TestView = () => {
  const { projects, currentProject, addTest, updateTest, addGrain, updateGrain, setGrains } = useContractStore()

  const project = useMemo(() => projects.find(p => p.title === currentProject), [currentProject, projects])
  const { testData, molds } = useMemo(() => project || EMPTY_PROJECT, [project])

  const [showTestModal, setShowTestModal] = useState(false)
  const [showGrainModal, setShowGrainModal] = useState(false)
  const [grainFormValues, setGrainFormValues] = useState<{ [key: string]: FormField }>({})
  const [testFormValues, setTestFormValues] = useState<{ [key: string]: FormField }>({})
  const [grainType, setGrainType] = useState('')
  const [actionType, setActionType] = useState('')
  const [edit, setEdit] = useState<Test | TestGrain | undefined>()

  const isMobile = isMobileCheck()

  const selectRice = useCallback((rice, grain?) => {
    setGrainFormValues(generateFormValues('grain', molds.rice[rice], grain))
    setGrainType(rice)
  }, [molds.rice, setGrainFormValues])

  const editGrain = useCallback((grain: TestGrain) => {
    selectRice(grain.type, grain)
    setShowGrainModal(true)
    setEdit(grain)
  }, [selectRice, setShowGrainModal])

  const selectAction = useCallback((action, test?) => {
    setTestFormValues(generateFormValues('test', molds.actions[action], test))
    setActionType(action)
  }, [molds.actions, setTestFormValues])

  const editTest = useCallback((test: Test) => {
    selectAction(test.input.action.type, test)
    setShowTestModal(true)
    setEdit(test)
  }, [selectAction, setShowTestModal])

  const updateGrainFormValue = useCallback((key: string, value: string) => {
    const newValues = { ...grainFormValues }
    newValues[key].value = value
    setGrainFormValues(newValues)
  }, [grainFormValues, setGrainFormValues])

  const updateTestFormValue = useCallback((key: string, value: string) => {
    const newValues = { ...testFormValues }
    newValues[key].value = value
    setTestFormValues(newValues)
  }, [testFormValues, setTestFormValues])

  const submitTest = useCallback((isUpdate = false) => () => {
    const validationError = validateFormValues(testFormValues)

    if (validationError) {
      return window.alert(validationError)
    }

    if (isUpdate && edit) {
      const newTest = testFromForm(testFormValues, actionType)
      const oldTest = edit as any
      newTest.input.cart.grains = oldTest.input.cart.grains
      newTest.input.cart.batch = oldTest.input.cart.batch
      Object.keys(oldTest.input.action).forEach(key => {
        if (testFormValues[key].type.includes('%grain')) {
          newTest.input.action[key] = oldTest.input.action[key]
        }
      })
      updateTest(newTest)
    } else {
      addTest(testFromForm(testFormValues, actionType))
    }
    setActionType('')
    setShowTestModal(false)
    setTestFormValues({})
    setEdit(undefined)
  }, [actionType, testFormValues, edit, addTest, updateTest])

  const submitGrain = useCallback((isUpdate = false) => () => {
    const validationError = validateFormValues(grainFormValues)

    if (validationError) {
      return window.alert(validationError)
    }

    const newGrain = grainFromForm(grainFormValues, grainType)

    if (isUpdate) {
      updateGrain(newGrain)
    } else {
      addGrain(newGrain)
    }
    setGrainType('')
    setShowGrainModal(false)
    setGrainFormValues({})
    setEdit(undefined)
  }, [grainType, grainFormValues, addGrain, updateGrain])

  const handleDragAndDropGrain = useCallback(({ source, destination }) => {
    if (!destination)
      return;

    if (source.droppableId === 'grains') {
      if (destination.droppableId === 'grains') {
        const newGrains = [ ...testData.grains ]
        const reorderedItem = newGrains.splice(source.index, 1)[0];
        newGrains.splice(destination.index, 0, reorderedItem);
        return setGrains(newGrains)
      }
      // if the source is "grains", then add to the destination action or cart as appropriate
      const [batch, iden]: string[] = destination.droppableId.split(DROPPABLE_DIVIDER)
      const test = testData.tests.find((t) => t.input.cart.batch === Number(batch))
      if (test) {
        const newTest = { ...test }
        const field: any = newTest.input.action[iden]

        if (field instanceof Array) {
          if (!field.find((g: string) => g === testData.grains[source.index].id)) {
            // replace the grain entirely if the type is not a %set, %list, %map
            const typeInfo = molds.actions[newTest.input.action.type as string][iden] as (string | string[])
            if (typeInfo === '%grain' || (typeInfo.includes('%grain') && typeInfo.includes('%unit'))) {
              newTest.input.action[iden] = [testData.grains[source.index].id]
            } else {
              field.push(testData.grains[source.index].id)
            }
          }
        } else {
          if (!newTest.input.cart.grains.find((g) => g === testData.grains[source.index].id)) {
            newTest.input.cart.grains.push(testData.grains[source.index].id)
          }
        }
        updateTest(newTest)
      }
    } else {
      // if the source is not "grains", then remove from the source action or cart as appropriate

    }
  }, [testData, molds, updateTest, setGrains]);

  const hideTestModal = () => {
    if (window.confirm('Are you sure you want to discard your changes?')) {
      setTestFormValues({})
      setShowTestModal(false)
      setEdit(undefined)
      setActionType('')
    }
  }

  const hideGrainModal = () => {
    if (window.confirm('Are you sure you want to discard your changes?')) {
      setGrainFormValues({})
      setShowGrainModal(false)
      setEdit(undefined)
      setGrainType('')
    }
  }

  const isEdit = Boolean(edit)

  return (
    <DragDropContext onDragEnd={handleDragAndDropGrain}>
      <Row className="tests" style={{ flexDirection: isMobile ? 'column' : 'row' }}>
        <Col style={{ height: isMobile ? 600 : '100%', width: isMobile ? '100%' : '50%' }}>
          <Row className="section-header">
            <Row className="title">Tests</Row>
            <Row className="action" onClick={() => setShowTestModal(true)}>+ Add Test</Row>
          </Row>
          <TestList editTest={editTest} molds={molds} />
        </Col>
        <Col style={{ height: isMobile ? 600 : '100%', width: isMobile ? '100%' : '50%' }}>
          <Col style={{ height: isMobile ? 400 : '70%', width: '100%', borderLeft: '1px solid lightgray' }}>
            <Row className="section-header">
              <Row className="title">Test Grains</Row>
              <Row className="action" onClick={() => setShowGrainModal(true)}>+ Add Grain</Row>
            </Row>
            <GrainList editGrain={editGrain} />
          </Col>
          <Iframe url={WEBTERM_PATH} height={isMobile? '200px' : '30%'} width='100%' />
        </Col>
        <Modal show={showTestModal} hide={hideTestModal}>
          <Col style={{ minWidth: 320, maxHeight: 'calc(100vh - 80px)', overflow: 'scroll' }}>
            <h3 style={{ marginTop: 0 }}>Add New Test</h3>
            <Select onChange={(e) => selectAction(e.target.value)} value={actionType} disabled={isEdit}>
              <option>Select an Action Type</option>
              {Object.keys(molds.actions).map(key => (
                <option key={key} value={key}>{key}</option>
              ))}
            </Select>
            {Object.keys(testFormValues).map((key) => (
              testFormValues[key].type.includes('%grain') ? 
              null :
              <div key={key}>
                {key === '%id' && <h4 key="cart" style={{ marginBottom: 0 }}>Cart</h4>}
                <Input
                  onChange={(e) => updateTestFormValue(key, e.target.value)}
                  value={testFormValues[key].value}
                  label={key}
                  placeholder={`${key} (${testFormValues[key].type})`}
                />
                {key === 'town-id' && <h4 key="town-id" style={{ marginBottom: 0 }}>Action</h4>}
              </div>
            ))}
            <Button onClick={submitTest(isEdit)} style={{ alignSelf: 'center', marginTop: 16 }}>{isEdit ? 'Update' : 'Add'} Test</Button>
          </Col>
        </Modal>
        <Modal show={showGrainModal} hide={hideGrainModal}>
          <Col style={{ minWidth: 320, maxHeight: 'calc(100vh - 80px)', overflow: 'scroll' }}>
            <h3 style={{ marginTop: 0 }}>Add New Grain</h3>
            <Select onChange={(e) => selectRice(e.target.value)} value={grainType} disabled={isEdit}>
              <option>Select a Grain Type</option>
              {Object.keys(molds.rice).map(key => (
                <option key={key} value={key}>{key}</option>
              ))}
            </Select>
            {Object.keys(grainFormValues).map((key) => (
              <Input
                disabled={key === 'id' && isEdit}
                key={key}
                onChange={(e) => updateGrainFormValue(key, e.target.value)}
                value={grainFormValues[key].value}
                label={`${key} (${JSON.stringify(grainFormValues[key].type).replace(/"/g, '')})`}
                placeholder={key}
                containerStyle={{ marginTop: 4 }}
              />
            ))}
            <Button onClick={submitGrain(isEdit)} style={{ alignSelf: 'center', marginTop: 16 }}>{isEdit ? 'Update' : 'Add'} Grain</Button>
          </Col>
        </Modal>
      </Row>
    </DragDropContext>
  )
}
