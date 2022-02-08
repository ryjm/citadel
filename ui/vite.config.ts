import { loadEnv, defineConfig } from 'vite';
import reactRefresh from '@vitejs/plugin-react-refresh';
import analyze from 'rollup-plugin-analyzer';
import { visualizer } from 'rollup-plugin-visualizer';
import { urbitPlugin } from '@urbit/vite-plugin-urbit';

// https://vitejs.dev/config/
export default ({ mode }) => {
  const viteEnv = loadEnv(mode, process.cwd());
  const SHIP_URL = viteEnv.SHIP_URL || viteEnv.VITE_SHIP_URL || 'http://localhost:8080';
  console.log(SHIP_URL);

  return defineConfig({
    build:
      mode !== 'profile'
        ? undefined
        : {
            rollupOptions: {
              plugins: [
                analyze({
                  limit: 20
                }),
                visualizer()
              ]
            }
          },
    plugins: [urbitPlugin({ base: 'citadel', target: SHIP_URL, secure: false }), reactRefresh()]
  });
};
