/// <reference types="vite/client" />

import createReScriptPlugin from '@jihchi/vite-plugin-rescript';
import createReactPlugin from '@vitejs/plugin-react';
import { defineConfig } from 'vite';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [createReactPlugin(), createReScriptPlugin()],
});
