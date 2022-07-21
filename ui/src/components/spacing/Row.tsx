import React from 'react'
import './Row.scss'

interface RowProps extends React.HTMLAttributes<HTMLDivElement> {
  innerRef?: any
}

const Row: React.FC<RowProps> = ({ innerRef, ...props }) => {
  return (
    <div {...props} ref={innerRef} className={`row ${props.className || ''}`}>
      {props.children}
    </div>
  )
}

export default Row
