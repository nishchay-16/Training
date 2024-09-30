import { useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Register from './pages/register';
import Login from './pages/login';
import Refer from './pages/refers';
import Transaction from './pages/transaction';

function App() {
  useEffect(() => {
    const script = document.createElement('script');
    script.textContent = `
      !function(m,a,i,t,r,e){if(m.RH)return;r=m.RH={},r.uuid
      =t,r.loaded=0,r.base_url=i,r.queue=[],m.rht=function()
      {r.queue.push(arguments)};e=a.getElementsByTagName('script')
      [0],c=a.createElement('script');c.async=!0,c.src=
      'https://referralhero-global-code.s3.amazonaws.com/'+'production'+
      '/'+t+'.js',e.parentNode.insertBefore(c,e)}(window,document,
      'https://app.referralhero.com/','RHe889790949');
    `;

    document.body.appendChild(script);

    return () => {
      document.body.removeChild(script);
    };
  }, []);

  return (
    <Router>
      <div className="App">
        <h1>Welcome to My App</h1>
        
        {/* Link to navigate to Register page */}
        <Link to="/register">Go to Register</Link><br/>
        <Link to="/login">Go to Login</Link><br/>
        <Link to="/refer">Go to Refer</Link><br/>
        <Link to="/transaction">Go to Transaction</Link><br/>

        <Routes>
          <Route path="/register" element={<Register />} />
          <Route path="/login" element={<Login />} />
          <Route path="/refer" element={<Refer />} />
          <Route path="/transaction" element={<Transaction />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
