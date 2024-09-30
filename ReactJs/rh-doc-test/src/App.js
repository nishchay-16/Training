import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Register from './pages/register';
import Login from './pages/login';
import Refer from './pages/refers';
import Transaction from './pages/transaction';
import PostList from './pages/postlist';

function App() {

  return (
    <Router>
      <div className="App">
        <h1>Welcome to My App</h1>
        
        {/* Link to navigate to Register page */}
        <Link to="/register">Go to Register</Link><br/>
        <Link to="/login">Go to Login</Link><br/>
        <Link to="/refer">Go to Refer</Link><br/>
        <Link to="/transaction">Go to Transaction</Link><br/>
        <Link to="/postlist">Go to PostList</Link><br/>

        <Routes>
          <Route path="/register" element={<Register />} />
          <Route path="/login" element={<Login />} />
          <Route path="/refer" element={<Refer />} />
          <Route path="/transaction" element={<Transaction />} />
          <Route path="/postlist" element={<PostList />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
