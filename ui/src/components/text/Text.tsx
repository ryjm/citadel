import React from 'react'
import './Text.scss'

interface TextProps extends React.HTMLAttributes<HTMLSpanElement> {
  mono?: boolean
}

const Text: React.FC<TextProps> = ({
  mono = false,
  ...props
}) => {
  return (
    <span {...props} className={`text ${props.className || ''} ${mono ? 'mono' : ''}`}>
      {props.children}
    </span>
  )
}

export default Text
