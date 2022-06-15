import React from 'react'
import './Loader.scss'

export interface LoaderProps extends React.HTMLAttributes<HTMLDivElement> {
}

const Loader: React.FC<LoaderProps> = ({
  ...props
}) => {
  return <div className="lds-ring" {...props}><div></div><div></div><div></div><div></div></div>
}

export default Loader
