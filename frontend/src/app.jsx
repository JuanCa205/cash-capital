import React, { useState, useEffect } from 'react'

function App() {
  const [backendStatus, setBackendStatus] = useState('checking')
  const [healthData, setHealthData] = useState(null)

  // Verificar conexión con el backend
  useEffect(() => {
    const checkBackend = async () => {
      try {
        const response = await fetch('http://localhost:3001/api/health')
        const data = await response.json()
        setHealthData(data)
        setBackendStatus('connected')
      } catch (error) {
        setBackendStatus('error')
        console.error('Error conectando al backend:', error)
      }
    }

    checkBackend()
  }, [])

  return (
    <div style={{ padding: '2rem', fontFamily: 'Arial, sans-serif' }}>
      <h1>🎯 Cash Capital</h1>
      <p>App de Gamificación Económica</p>
      
      <div style={{ marginTop: '2rem', padding: '1rem', border: '1px solid #ccc', borderRadius: '8px' }}>
        <h2>Estado del Sistema</h2>
        
        <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
          <div style={{ 
            padding: '0.5rem 1rem', 
            borderRadius: '4px', 
            backgroundColor: backendStatus === 'connected' ? '#22c55e' : 
                           backendStatus === 'error' ? '#ef4444' : '#f59e0b',
            color: 'white'
          }}>
            Backend: {backendStatus === 'connected' ? '✅ Conectado' : 
                     backendStatus === 'error' ? '❌ Error' : '⏳ Verificando...'}
          </div>
          
          <div style={{ 
            padding: '0.5rem 1rem', 
            borderRadius: '4px', 
            backgroundColor: '#3b82f6',
            color: 'white'
          }}>
            Frontend: ✅ Ejecutándose
          </div>
        </div>

        {healthData && (
          <div style={{ marginTop: '1rem', padding: '1rem', backgroundColor: '#f3f4f6', borderRadius: '4px' }}>
            <h3>Información del Backend:</h3>
            <pre>{JSON.stringify(healthData, null, 2)}</pre>
          </div>
        )}
      </div>

      <div style={{ marginTop: '2rem' }}>
        <h3>Próximos Pasos:</h3>
        <ul>
          <li>✅ Configurar Docker y contenedores</li>
          <li>⚙️ Configurar base de datos PostgreSQL</li>
          <li>🎨 Crear interfaz de usuario con React</li>
          <li>🔐 Implementar sistema de autenticación</li>
          <li>🎮 Agregar mecánicas de gamificación</li>
        </ul>
      </div>
    </div>
  )
}

export default App