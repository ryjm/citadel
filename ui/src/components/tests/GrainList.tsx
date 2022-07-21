import React, { useMemo, useState } from 'react'
import { Droppable, Draggable } from 'react-beautiful-dnd'
import { FaChevronDown, FaChevronUp, FaPen } from 'react-icons/fa';
import Col from '../spacing/Col'
import Row from '../spacing/Row'
import useContractStore from '../../store/contractStore';
import { TestGrain } from '../../types/TestGrain';
import { Values } from './TestList';
import Button from '../form/Button';

import './GrainList.scss'
import { EMPTY_PROJECT } from '../../types/Project';

  // <Draggable key={group} draggableId={group} index={index}>
  //     {provided => <Box ref={provided.innerRef} {...provided.draggableProps} {...provided.dragHandleProps}>
  //       <GroupTile {...{ title, group }} />
  //     </Box>}
  //   </Draggable>


  // <Droppable droppableId={title} style={{ width: '100%' }}>
  //             {provided => (
  //               <Box {...provided.droppableProps} ref={provided.innerRef} backgroundColor="washedGray" mx={-2} mt={2} px={1} py={0} borderRadius={2} minHeight="60px">
  //                 {groups.map((g, i) => {
  //                   return (!g || !getTitle(g)) ? null : <GroupCard key={g} title={getTitle(g)} group={g} index={i} />;
  //                 })}
  //                 {provided.placeholder}
  //               </Box>
  //             )}
  //           </Droppable>

interface GrainValueDisplayProps extends GrainListProps {
  grain: TestGrain
  grainIndex: number
}

export const GrainValueDisplay = ({ grain, grainIndex, editGrain }: GrainValueDisplayProps) => {
  const { removeGrain } = useContractStore()
  const [expanded, setExpanded] = useState(false)

  const grainStyle = {
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    width: 'calc(100% - 32px)',
    margin: 8,
    padding: 8,
    border: '1px solid black',
    borderRadius: 4,
    background: 'white',
  }

  const grainContent = (
    <Row style={{ ...grainStyle, position: 'relative' }}>
      <Col>
        <Row>
          <Button
            onClick={() => setExpanded(!expanded)}
            variant='unstyled'
            style={{ marginRight: 8, marginTop: 2, alignSelf: 'flex-start' }}
            iconOnly
            icon={expanded ? <FaChevronUp size={16} /> : <FaChevronDown size={16} />}
          />
          <Col>
            <div>ID: {grain.id}</div>
            {expanded && <div>Holder: {grain.holder}</div>}
            {expanded && <div>Lord: {grain.lord}</div>}
            {expanded && <div>Town ID: {grain['town-id']}</div>}
          </Col>
        </Row>
      </Col>
      {expanded && <Col>
        <div>Rice:</div>
        <Values values={grain.rice} />
      </Col>}
      <Row style={{ position: 'absolute', top: 4, right: 4, padding: 4 }}>
        <Button
          onClick={() => editGrain(grain)}
          variant='unstyled'
          className="delete"
          iconOnly
          icon={<FaPen size={14} />}
        />
        <Button
          onClick={() => { if(window.confirm('Are you sure you want to remove this grain?')) removeGrain(grainIndex) }}
          variant='unstyled'
          className="delete"
          style={{ fontSize: 20, marginLeft: 8 }}
        >
          &times;
        </Button>
      </Row>
    </Row>
  )

  return (
    <Draggable draggableId={grain.id} index={grainIndex}>
      {(provided: any, snapshot: any) => (
        <>
          <Row key={grain.id} className="grain" innerRef={provided.innerRef} {...provided.draggableProps} {...provided.dragHandleProps}>
            {grainContent}
          </Row>
          {snapshot.isDragging && snapshot.draggingOver !== 'grains' && <Row className='grain'>{grainContent}</Row>}
        </>
      )}
    </Draggable>
  )
}

interface GrainListProps {
  editGrain: (grain: TestGrain) => void
}

export const GrainList = ({ editGrain }: GrainListProps) => {
  const { projects, currentProject } = useContractStore()
  const project = useMemo(() => projects.find(p => p.title === currentProject), [currentProject, projects])
  const { testData } = useMemo(() => project || EMPTY_PROJECT, [project])

  return (
    <Droppable droppableId="grains" style={{ width: '100%', height: '100%' }}>
      {(provided: any) => (
        <Col className='grains' {...provided.droppableProps} innerRef={provided.innerRef} style={{ ...provided.droppableProps.style,  width: '100%', overflow: 'scroll' }}>
          {testData.grains.map((grain, i) => (
            <GrainValueDisplay key={grain.id} grain={grain} grainIndex={i} editGrain={editGrain} />
          ))}
          {provided.placeholder}
        </Col>
      )}
    </Droppable>
  )
}
