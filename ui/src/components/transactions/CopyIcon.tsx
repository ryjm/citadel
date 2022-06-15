import React, { useCallback, useState } from 'react'
import { FaCopy } from 'react-icons/fa';
import Row from '../spacing/Row'
import Text from '../text/Text';
import './CopyIcon.scss'

interface CopyIconProps extends React.HTMLAttributes<HTMLDivElement> {
  text: string
}

const CopyIcon: React.FC<CopyIconProps> = ({
  text,
  ...props
}) => {
  const [didCopy, setDidCopy] = useState(false)

  const onCopy = useCallback(() => {
    navigator.clipboard.writeText(text)
    setDidCopy(true)
    setTimeout(() => setDidCopy(false), 1000)
  }, [text])

  return (
    <Row style={{ marginLeft: 12, padding: '2px 4px' }} className="icon" onClick={onCopy}>
      {didCopy ? <Text style={{ fontSize: 14 }}>Copied!</Text> : <FaCopy />}
    </Row>
  )
}

export default CopyIcon
