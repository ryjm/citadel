// React.HTMLProps<HTMLButtonElement>
import React from 'react'
import './Button.scss'

export type ButtonVariant = 'dark' | 'unstyled' | undefined

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: ButtonVariant 
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
