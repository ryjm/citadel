import React from 'react'
import './Col.scss'

interface ColProps extends React.HTMLAttributes<HTMLDivElement> {

}

const Col: React.FC<ColProps> = (props) => {
  return (
    <div {...props} className={`col ${props.className || ''}`}>
      {props.children}
    </div>
  )
}

export default Col
