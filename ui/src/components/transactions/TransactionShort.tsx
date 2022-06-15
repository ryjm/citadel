import React from 'react'
import { Transaction } from '../../types/Transaction';
import { getStatus } from '../../utils/constants';
import { formatHash } from '../../utils/format';
import Link from '../nav/Link';
import Col from '../spacing/Col';
import Row from '../spacing/Row'
import Text from '../text/Text';
import CopyIcon from './CopyIcon';
import './TransactionShort.scss'

interface TransactionShortProps extends React.HTMLAttributes<HTMLDivElement> {
  txn: Transaction
}

const TransactionShort: React.FC<TransactionShortProps> = ({
  txn,
  ...props
}) => {
  return (
    <Col {...props} className={`transaction-short ${props.className || ''}`}>
      <Row>
        <Text style={{ marginRight: 31 }}>Hash: </Text>
        <Link href={`/transactions/${txn.hash}`}>
          <Text mono>{formatHash(txn.hash)}</Text>
        </Link>
        <CopyIcon text={txn.hash} />
      </Row>
      <Row style={{ justifyContent: 'space-between' }}>
        <Row>
          <Text style={{ marginRight: 22 }}>Status: </Text>
          <Text mono>{getStatus(txn.status)}</Text>
        </Row>
        {txn.created && <Text mono>{txn.created.toDateString()}</Text>}
      </Row>
    </Col>
  )
}

export default TransactionShort
