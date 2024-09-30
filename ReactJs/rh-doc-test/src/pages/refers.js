import React, { useEffect } from 'react';

const Refer = () => {

  useEffect(() => {
    window.RHConfig = {
      callbacks: {
        ready: function () {
          const form = document.getElementById("organic-referral-form");
          if (form) {
            form.addEventListener("submit", function (e) {
              e.preventDefault(); 
              const data = {
                name: form.querySelector('#name').value, 
                email: form.querySelector('#email').value,
                phone_number: form.querySelector('#phone').value,
              };
              window.RH_MF59c73b67c4.organicTrackReferral( data);
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
    <form id="organic-referral-form">
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
      <input 
        type="text" 
        id='phone'
        placeholder="Phone" 
        required
      />
      <button type="submit">Submit</button>
    </form>
  );
};

export default Refer;
