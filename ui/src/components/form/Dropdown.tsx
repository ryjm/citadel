import React, { useState } from 'react'
import Col from '../spacing/Col'
import './Dropdown.scss'

interface DropdownProps extends React.HTMLAttributes<HTMLDivElement> {
  content: (setOpen: Function) => React.ReactElement
  contentStyle?: React.CSSProperties
}

const Dropdown: React.FC<DropdownProps> = ({
  content,
  children,
  contentStyle,
  ...props
}) => {
  const [open, setOpen] = useState(false)

  return (
    <div {...props} className={`dropdown ${props.className || ''}`} onClick={() => {
      setOpen(!open)
      }}>
      {open && <div className="background" onClick={() => setOpen(false)} />}
      {children}
      {open && (
        <Col className="content" style={contentStyle}>
          {content(setOpen)}
        </Col>
      )}
    </div>
  )
}

export default Dropdown
