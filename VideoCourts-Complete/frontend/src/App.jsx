import { useState, useEffect } from 'react'
import axios from 'axios'

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000'

function App() {
  const [health, setHealth] = useState(null)

  useEffect(() => {
    axios.get(`${API_URL}/api/health`)
      .then(res => setHealth(res.data))
      .catch(err => console.error(err))
  }, [])

  return (
    <div style={{ padding: '2rem', fontFamily: 'system-ui' }}>
      <h1>VideoCourts™</h1>
      <p>Virtual Justice Platform</p>

      {health ? (
        <div>
          <h2>Backend Status</h2>
          <pre>{JSON.stringify(health, null, 2)}</pre>
        </div>
      ) : (
        <p>Loading backend status...</p>
      )}
    </div>
  )
}

export default App
