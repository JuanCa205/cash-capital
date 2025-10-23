import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    host: true, // Esto permite acceso desde fuera del contenedor
  },
  resolve: {
    alias: {
      // Aquí puedes agregar aliases para imports más tarde
    },
  },
})