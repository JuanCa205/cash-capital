import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import Signup from './pages/Signup.jsx'
import Men from './pages/Men.jsx'
import Login from './pages/login.jsx'

const router = createBrowserRouter([
  {
    path: '/status',
    element: <App /> ,
//     errorElement:
  },
  {
    path: '/signup',
    element: <Signup /> ,
  },
  {
    path: '/menu',
    element: <Men /> ,
  },
  {
    path: '/login',
    element: <Login /> ,
  }
])

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>,
)