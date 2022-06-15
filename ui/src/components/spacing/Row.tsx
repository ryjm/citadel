import React from 'react'
import './Row.scss'

interface RowProps extends React.HTMLAttributes<HTMLDivElement> {

}

const Row: React.FC<RowProps> = (props) => {
  return (
    <div {...props} className={`row ${props.className || ''}`}>
      {props.children}
    </div>
  )
}

export default Row
