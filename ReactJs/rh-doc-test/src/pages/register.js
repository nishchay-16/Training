import React, { useState } from 'react';

const Register = () => {
  const [email, setEmail] = useState('');
  const [name, setName] = useState('');
  const [phone, setPhone] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();

    const data = {
      email: email,
      name: name,
      phone_number: phone,
    };
    
    if (window.RH_MF59c73b67c4) {
      window.RH_MF59c73b67c4.form.submit(data)
      console.log("Subscriber created or tracked successfully");
    } else {
      console.log("Subscriber not tracked");
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input 
        type="text" 
        value={name} 
        onChange={(e) => setName(e.target.value)} 
        placeholder="Name" 
        required 
      />
      <input 
        type="email" 
        value={email} 
        onChange={(e) => setEmail(e.target.value)} 
        placeholder="Email" 
        required 
      />
      <input 
        type="text" 
        value={phone} 
        onChange={(e) => setPhone(e.target.value)} 
        placeholder="Phone Number" 
      />
      <button type="submit">Submit</button>
    </form>
  );
};

export default Register;
