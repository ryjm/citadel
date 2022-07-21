import React from 'react'
import './Col.scss'

interface ColProps extends React.HTMLAttributes<HTMLDivElement> {
  innerRef?: any
}

const Col: React.FC<ColProps> = ({ innerRef, ...props }: ColProps) => {
  return (
    <div ref={innerRef} {...props} className={`col ${props.className || ''}`}>
      {props.children}
    </div>
  )
}

export default Col
