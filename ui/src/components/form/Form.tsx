import React from 'react'
import Col from '../spacing/Col'
import Text from '../text/Text'
import './Form.scss'

interface FormProps extends React.FormHTMLAttributes<HTMLFormElement> {
}

const Form: React.FC<FormProps> = ({
  ...props
}) => {
  return (
    <form {...props} className={`form ${props.className || ''}`}>
      {props.children}
    </form>
  )
}

export default Form
