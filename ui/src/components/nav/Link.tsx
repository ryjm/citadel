import React from 'react'
import useContractStore from '../../store/contractStore';
import './Link.scss'

interface LinkProps extends React.HTMLAttributes<HTMLDivElement> {
  href: string;
  type?: string;
  underline?: boolean
}

const Link: React.FC<LinkProps> = ({
  href,
  type = '',
  underline = false,
  ...props
}) => {
  const { setRoute } = useContractStore()
  const [route, subRoute] = href.replace(/^\//, '').split('/')

  return (
    <div /*href={process.env.PUBLIC_URL + href}*/ {...props} onClick={(e) => {
      if (props.onClick) {
        props.onClick(e)
      } else {
        console.log(route, subRoute)
        setRoute({ route, subRoute })
      }
    }} className={`link ${props.className || ''} ${type} ${underline ? 'underline' : ''}`}>
      {props.children}
    </div>
  )
}

export default Link
