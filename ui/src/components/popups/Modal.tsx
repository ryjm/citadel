import React, { MouseEvent } from "react"

import "./Modal.scss"

export interface ModalProps extends React.HTMLAttributes<HTMLDivElement> {
  show: boolean
  hide: () => void
  hideClose?: boolean
  children: React.ReactNode
}

const Modal: React.FC<ModalProps> = ({
  show,
  hide,
  hideClose = false,
  ...props
}) => {
  const dontHide = (e: MouseEvent) => {
    e.stopPropagation()
  }

  if (!show) {
    return null
  }

  return (
    <div className="modal" onClick={hide}>
      <div {...props} className={`content ${props.className || ''}`}>
        {!hideClose && (
          <div className="close" onClick={hide}>
            &#215;
          </div>
        )}
        <div style={{ height: '100%' }} onClick={dontHide}>{props.children}</div>
      </div>
    </div>
  )
}

export default Modal
