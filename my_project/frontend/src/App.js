import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [message, setMessage] = useState('Loading...');
  const [apiData, setApiData] = useState(null);
  const [name, setName] = useState('');
  const [greeting, setGreeting] = useState('');
  const [loading, setLoading] = useState(false);

  // Fetch initial message from API
  useEffect(() => {
    fetchHelloMessage();
  }, []);

  const fetchHelloMessage = async () => {
    try {
      const response = await fetch('/api/hello');
      const data = await response.json();
      setMessage(data.message);
      setApiData(data);
    } catch (error) {
      console.error('Error fetching data:', error);
      setMessage('Error connecting to API');
    }
  };

  const handleGreet = async (e) => {
    e.preventDefault();
    if (!name.trim()) return;

    setLoading(true);
    try {
      const response = await fetch(`/api/greet/${encodeURIComponent(name)}`);
      const data = await response.json();
      setGreeting(data.message);
    } catch (error) {
      console.error('Error fetching greeting:', error);
      setGreeting('Error fetching greeting');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="App">
      <div className="container">
        <header className="header">
          <h1 className="title">🎉 Hello World App</h1>
          <p className="subtitle">FastAPI + React on Databricks</p>
        </header>

        <div className="card">
          <div className="card-content">
            <h2 className="card-title">API Response</h2>
            <p className="message">{message}</p>
            {apiData && (
              <div className="api-details">
                <p className="detail">📝 {apiData.description}</p>
                <p className="detail">🔢 Version: {apiData.version}</p>
              </div>
            )}
          </div>
        </div>

        <div className="card">
          <div className="card-content">
            <h2 className="card-title">Personalized Greeting</h2>
            <form onSubmit={handleGreet} className="form">
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="Enter your name"
                className="input"
              />
              <button 
                type="submit" 
                className="button"
                disabled={loading || !name.trim()}
              >
                {loading ? 'Loading...' : 'Get Greeting'}
              </button>
            </form>
            {greeting && (
              <div className="greeting-result">
                <p className="greeting">{greeting}</p>
              </div>
            )}
          </div>
        </div>

        <footer className="footer">
          <p>Built with ❤️ using FastAPI + React</p>
          <p className="footer-small">Deployed on Databricks Asset Bundle</p>
        </footer>
      </div>
    </div>
  );
}

export default App;

