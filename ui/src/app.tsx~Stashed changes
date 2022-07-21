import React, { useEffect } from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import useContractStore from './store/contractStore';
import Container from './components/spacing/Container';
import Col from './components/spacing/Col';
import Row from './components/spacing/Row';
import { Sidebar } from './components/nav/Sidebar';
import MainView from './views/MainView';

function App() {
  const { init } = useContractStore()

  useEffect(() => {
    init()
  }, []) // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <Container>
      <BrowserRouter basename={process.env.PUBLIC_URL}>
      <Col style={{ width: '100%', height: '100%' }}>
        <Row style={{ height: '100%', width: '100%' }}>
          <Col style={{ height: '100%', width: '20%', maxWidth: 240 }}>
            <Sidebar />
          </Col>
          <Col style={ {minWidth: '80%', width: 'calc(100% - 240px)', height: '100%', position: 'relative' }}>
            <Routes>
              <Route path="/" element={<MainView />} />
              {/* <Route path="/" element={<EditorView />} />
              <Route path="/new" element={<NewProjectView />} />
              <Route path="/app" element={<AppView />} />
              <Route path="/app/:app" element={<AppView />} /> */}
              <Route
                path="*"
                element={
                  <main style={{ padding: "1rem" }}>
                    <p>There's nothing here!</p>
                  </main>
                }
              />
            </Routes>
          </Col>
        </Row>
      </Col>
      </BrowserRouter>
    </Container>
  );
}

export default App;
