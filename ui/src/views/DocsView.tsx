import React, { useEffect } from 'react'
import Iframe from 'react-iframe';
import Container from '../components/spacing/Container'

import './DocsView.scss'

const docsUrl = '/~/scry/docs/usr/citadel/overview.html'

const DocsView = () => {
  useEffect(() => {
    const checkDocsInstalled = async () => {
      const result = await fetch(docsUrl)
      if (result.status === 404) {
        alert(`There was an error loading %docs, please ensure you have installed %docs from ~pocwet.

You can run "|install ~pocwet %docs" in the webterm insert on the "Contract" page.`)
      }
    }

    checkDocsInstalled()
  }, [])

  return (
    <Container className='docs-view'>
      <Iframe url={docsUrl} height='100%' width='100%' />
    </Container>
  )
}

export default DocsView

// export function App() {
//   // const [firstRender, setFirstRender] = useState(false);
//   const windowRef = useRef<HTMLElement>(null);
//   const { termRatio } = windowSettings();
//   const [oldWidth, setOldWidth] = useState(termRatio * window.innerWidth);
//   const [currentWidth, setCurrentWidth] = useState(termRatio * window.innerWidth);
//   const [height, setHeight] = useState(window.innerHeight);
//   const docsWidth = window.innerWidth - currentWidth;
//   const strHeight = `${height}px`;
//   const minWidth = Math.max(window.innerWidth * .33, 400)
//   const maxWidth = Math.max(window.innerWidth - 400, window.innerWidth * .75);

//   const windowResize = useCallback(() => {
//     setHeight(window.innerHeight);
//     setCurrentWidth(termRatio * window.innerWidth);
//   }, [termRatio])

//   useEffect(() => {
//     window.addEventListener('resize', windowResize)

//     return () => {
//       window.removeEventListener('resize', windowResize);
//     }
//   }, [windowResize])

//   const onResize: ResizeCallback = (event, dir, ref, delta) => {
//     const newWidth = oldWidth + delta.width;
//     setCurrentWidth(newWidth);
//     windowSettings.setState({ termRatio: newWidth / window.innerWidth });
//   };

//   return (
//     <main ref={windowRef} className="flex">
//       <Resizable
//         size={{
//           height, 
//           width: currentWidth
//         }}
//         minWidth={minWidth}
//         maxWidth={maxWidth}
//         enable={{ right: true }}
//         handleComponent={{ right: Resizer() }}
//         onResizeStart={() => setOldWidth(currentWidth)}
//         onResize={onResize}
//       >
//         <div className='w-full h-full border-r border-gray-500'>
//           <Iframe url={termUrl} width="100%" height="100%" />
//         </div>
//       </Resizable>
//       <Iframe url={docsUrl} height={strHeight} width={`${docsWidth}px`} />
//     </main>
//   );
// }
