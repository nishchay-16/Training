import React, { useEffect } from 'react';

const Login = () => {

  useEffect(() => {
    window.RHConfig = {
      callbacks: {
        ready: function () {
          const form = document.getElementById("referral-form");
          if (form) {
            form.addEventListener("submit", function (e) {
              e.preventDefault(); 
              const data = {
                name: form.querySelector('#name').value, 
                email: form.querySelector('#email').value,
              };
              window.RH.pendingReferral(data);
              console.log("Referral submitted:", data); 
            });
          }
        },
      },
    };

    return () => {
      window.RHConfig = {};
    };
  }, []); 

  return (
    <form id="referral-form">
      <input 
        type="text" 
        id="name"
        placeholder="Name" 
        required 
      />
      <input 
        type="email" 
        id="email"
        placeholder="Email" 
        required 
      />
      <button type="submit">Submit</button>
    </form>
  );
};

export default Login;
