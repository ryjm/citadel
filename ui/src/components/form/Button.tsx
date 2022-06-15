// React.HTMLProps<HTMLButtonElement>
import React from 'react'
import './Button.scss'

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: string
  icon?: JSX.Element
  iconOnly?: boolean
}

const Button: React.FC<ButtonProps> = ({
  variant,
  icon,
  iconOnly = false,
  type,
  ...props
}) => {
  return (
    <button {...props} className={`button ${props.className || ''} ${variant || ''}`} type={type || "button"}>
      {icon}
      {!iconOnly && props.children}
    </button>
  )
}

export default Button
