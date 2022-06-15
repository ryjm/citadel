import React from 'react'
import './TextArea.scss'

interface TextAreaProps extends React.HTMLAttributes<HTMLTextAreaElement> {
  ref: any
}

const TextArea: React.FC<TextAreaProps> = (props) => {
  return (
    <textarea {...props} className={`text-area ${props.className || ''}`} />
  )
}

export default TextArea
