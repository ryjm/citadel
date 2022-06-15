import React from 'react'
import './Link.scss'

interface LinkProps extends React.HTMLAttributes<HTMLAnchorElement> {
  href: string;
  type?: string;
}

const Link: React.FC<LinkProps> = ({
  href,
  type = '',
  ...props
}) => {
  return (
    <a href={process.env.PUBLIC_URL + href} {...props} className={`link ${props.className || ''} ${type}`}>
      {props.children}
    </a>
  )
}

export default Link
