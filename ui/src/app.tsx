import React, { useEffect } from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Navbar from './components/nav/Navbar';
import EditorView from './views/EditorView';
import DocsView from './views/DocsView';
import CliffView from './views/CliffView';
import useContractStore from './store/contractStore';

function App() {
  const { init } = useContractStore()

  useEffect(() => {
    init()
  }, []) // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <BrowserRouter basename={process.env.PUBLIC_URL}>
      <Navbar />
      <Routes>
        <Route path="/" element={<EditorView />} />
        <Route path="/gall" element={<EditorView />} />
        <Route path="/docs" element={<DocsView />} />
        <Route path="/cliff" element={<CliffView />} />
        <Route
          path="*"
          element={
            <main style={{ padding: "1rem" }}>
              <p>There's nothing here!</p>
            </main>
          }
        />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
