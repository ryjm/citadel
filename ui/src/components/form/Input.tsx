import React from 'react'
import Col from '../spacing/Col'
import './Input.scss'

interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label?: string
  containerStyle?: React.CSSProperties
}

const Input: React.FC<InputProps> = ({
  label,
  containerStyle,
  ...props
}) => {
  return (
    <Col className="input-container" style={containerStyle}>
      {!!label && <label style={{ fontSize: 14, marginBottom: 4 }}>{label}</label>}
      <input type="text" {...props} className={`input ${props.className || ''}`} />
    </Col>
  )
}

export default Input
