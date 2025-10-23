// Servidor básico de Express para desarrollo
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

// Cargar variables de entorno
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middlewares básicos
app.use(cors());
app.use(express.json());

// Ruta de salud para verificar que el servidor funciona
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    message: '🚀 Cash Capital Backend funcionando correctamente',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development'
  });
});

// Ruta de prueba de base de datos (simulada por ahora)
app.get('/api/test-db', (req, res) => {
  res.json({ 
    database: 'PostgreSQL', 
    status: 'Conectado (simulado)',
    message: 'La base de datos está lista para usar'
  });
});

// Manejo de rutas no encontradas
app.use('*', (req, res) => {
  res.status(404).json({ 
    error: 'Ruta no encontrada',
    availableRoutes: ['/api/health', '/api/test-db']
  });
});

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`🎯 Cash Capital Backend ejecutándose en puerto ${PORT}`);
  console.log(`📍 Health check: http://localhost:${PORT}/api/health`);
  console.log(`🌍 Environment: ${process.env.NODE_ENV || 'development'}`);
});