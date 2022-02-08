import React, { ReactElement, useCallback, useEffect, useRef, useState } from 'react';
import Iframe from 'react-iframe';
import { SelectorIcon } from '@heroicons/react/outline';
import { Resizable, ResizeCallback } from 're-resizable';
import create from 'zustand';
import { persist } from 'zustand/middleware'

const docsUrl = '/~/scry/docs/usr/citadel/overview.html'
const termUrl = '/apps/webterm'

const windowSettings = create(persist((set, get) => ({
  termRatio: .66
}), {
  name: 'citadel-settings'
}))

const Resizer = () => (
  <div className='absolute right-0 top-0 px-2 -mr-2'>
    <div className='flex items-center h-screen bg-gray-200'>
      <SelectorIcon className='h-6 w-6 text-gray-800 rotate-90' />
    </div>
  </div>
)

export function App() {
  // const [firstRender, setFirstRender] = useState(false);
  const windowRef = useRef<HTMLElement>(null);
  const { termRatio } = windowSettings();
  const [oldWidth, setOldWidth] = useState(termRatio * window.innerWidth);
  const [currentWidth, setCurrentWidth] = useState(termRatio * window.innerWidth);
  const [height, setHeight] = useState(window.innerHeight);
  const docsWidth = window.innerWidth - currentWidth;
  const strHeight = `${height}px`;
  const minWidth = Math.max(window.innerWidth * .33, 400)
  const maxWidth = Math.max(window.innerWidth - 400, window.innerWidth * .75);

  const windowResize = useCallback(() => {
    setHeight(window.innerHeight);
    setCurrentWidth(termRatio * window.innerWidth);
  }, [termRatio])

  useEffect(() => {
    window.addEventListener('resize', windowResize)

    return () => {
      window.removeEventListener('resize', windowResize);
    }
  }, [windowResize])

  const onResize: ResizeCallback = (event, dir, ref, delta) => {
    const newWidth = oldWidth + delta.width;
    setCurrentWidth(newWidth);
    windowSettings.setState({ termRatio: newWidth / window.innerWidth });
  };

  return (
    <main ref={windowRef} className="flex">
      <Resizable
        size={{
          height, 
          width: currentWidth
        }}
        minWidth={minWidth}
        maxWidth={maxWidth}
        enable={{ right: true }}
        handleComponent={{ right: Resizer() }}
        onResizeStart={() => setOldWidth(currentWidth)}
        onResize={onResize}
      >
        <div className='w-full h-full border-r border-gray-500'>
          <Iframe url={termUrl} width="100%" height="100%" />
        </div>
      </Resizable>
      <Iframe url={docsUrl} height={strHeight} width={`${docsWidth}px`} />
    </main>
  );
}
