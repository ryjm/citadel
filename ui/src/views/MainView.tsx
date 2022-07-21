import React from 'react'
import useContractStore from '../store/contractStore';
import AppView from './AppView';

import './DocsView.scss'
import EditorView from './EditorView';
import NewProjectView from './NewProjectView';

const MainView = () => {
  const { route } = useContractStore()

  return (
    <>
      <EditorView hide={!route.route.includes('contract')} />
      <NewProjectView hide={!route.route.includes('project') || !route.subRoute?.includes('new')} />
      <AppView hide={!route.route.includes('app')} />
    </>
  )
}

export default MainView
