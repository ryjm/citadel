import React from 'react'

interface LineProps extends React.HTMLAttributes<HTMLDivElement> {

}

const Line: React.FC<LineProps> = (props) => {
  return (
    <div {...props} style={{ height: '1px', width: '100%', background: 'gray', ...props.style }} />
  )
}

export default Line
