import React from 'react'
import './Container.scss'

interface ContainerProps extends React.HTMLAttributes<HTMLDivElement> {

}

const Container: React.FC<ContainerProps> = (props) => {
  return (
    <div {...props} className={`container ${props.className || ''}`}>
      {props.children}
    </div>
  )
}

export default Container
