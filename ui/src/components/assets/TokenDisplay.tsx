import React, { useState } from 'react'
import { FaCaretRight, FaCaretDown } from 'react-icons/fa';
import useWalletStore from '../../store/walletStore';
import { TokenBalance } from '../../types/TokenBalance'
import { formatAmount } from '../../utils/number';
import Link from '../nav/Link';
import Col from '../spacing/Col';
import Row from '../spacing/Row'
import Text from '../text/Text';
import './TokenDisplay.scss'

interface TokenDisplayProps extends React.HTMLAttributes<HTMLDivElement> {
  tokenBalance: TokenBalance
}

const TokenDisplay: React.FC<TokenDisplayProps> = ({ tokenBalance, ...props }) => {
  const { metadata } = useWalletStore()
  const { lord, balance, town, riceId } = tokenBalance
  const [open, setOpen] = useState(false)
  const tokenMetadata = metadata[tokenBalance.data.metadata]

  return (
    <Col {...props} className={`token-display ${props.className || ''}`}>
      <Row style={{ justifyContent: 'space-between' }}>
        <Row>
          <Row onClick={() => setOpen(!open)} style={{ padding: '2px 4px', cursor: 'pointer' }}>
            {open ? <FaCaretDown /> : <FaCaretRight />}
          </Row>
          <Text mono>{tokenMetadata?.symbol || lord}</Text>
        </Row>
        <Row>
          <Text>{formatAmount(balance)}</Text>
          <Link href={`/send/${riceId}`} style={{ marginLeft: 16, padding: '4px 8px', fontSize: '14px' }} type="button dark">
            Transfer
          </Link>
        </Row>
      </Row>
      {open && (
        <Col style={{ paddingLeft: 24, paddingTop: 8 }}>
          {tokenMetadata && (
            <>
              <Row>
                <Text style={{ width: 80 }}>Name:</Text>
                <Text mono>{' ' + tokenMetadata.name}</Text>
              </Row>
            </>
          )}
          <Row>
            <Text style={{ width: 80 }}>Town:</Text>
            <Text mono>{' ' + town}</Text>
          </Row>
          <Row>
            <Text style={{ width: 80 }}>Rice ID:</Text>
            <Text mono>{' ' + riceId}</Text>
          </Row>
        </Col>
      )}
    </Col>
  )
}

export default TokenDisplay
