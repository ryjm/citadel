import React from 'react'
import Row from '../spacing/Row'
import Link from './Link'
// import logoWithText from '../../assets/img/uqbar-logo-text.png'
import logo from '../../assets/img/logo192.png'
import './Navbar.scss'
import { isMobileCheck } from '../../utils/dimensions'
import Dropdown from '../form/Dropdown'
import Text from '../text/Text'

const Navbar = () => {
  const isMobile = isMobileCheck()

  const dropdownContent = (setOpen: Function) => (
    <>
      <Text onClick={() => setOpen(false)}>Town 1</Text>
      <Text>Town 2</Text>
      <Text>Town 3</Text>
    </>
  )

  return (
    <Row className='navbar'>
      <Row>
        <div className="nav-link logo">
          <img src={logo} alt="Uqbar Logo" />
        </div>
      </Row>
      <Row style={{ marginRight: 8 }}>
        <Link className={`nav-link ${window.location.pathname === `${process.env.PUBLIC_URL}/` ? 'selected' : ''}`} href="/">Contract</Link>
        <Link className={`nav-link ${window.location.pathname.includes('/gall') ? 'selected' : ''}`} href="/gall">Gall App</Link>
        <Link className={`nav-link ${window.location.pathname.includes('/cliff') ? 'selected' : ''}`} href="/cliff">Cliff</Link>
        <Link className={`nav-link ${window.location.pathname.includes('/docs') ? 'selected' : ''}`} href="/docs">Docs</Link>
      </Row>
    </Row>
  )
}

export default Navbar
