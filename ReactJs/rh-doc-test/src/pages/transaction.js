import React, { useEffect } from 'react';

const Transaction = () => {

  useEffect(() => {
    window.RHConfig = {
      callbacks: {
        ready: function () {
          const form = document.getElementById("transaction-form");
          if (form) {
            form.addEventListener("submit", function (e) {
              e.preventDefault(); 
              const data = {
                  email: form.querySelector('#email').value,
                  amount: form.querySelector('#amount').value,
                  product_id: form.querySelector('#product_id').value,
                  transaction_id: form.querySelector('#transaction_id').value,
                };
              window.RH_MF59c73b67c4.trackTransaction(data);
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
    <form id="transaction-form">
      <input type="email" id="email" placeholder="Email" required />
      <input type="number" id="amount" placeholder="Amount" required />
      <input type="text" id="product_id" placeholder="Product ID" required />
      <input type="text" id="transaction_id" placeholder="Transaction ID" required /> 
      <button type="submit">Submit</button>
    </form>
  );
};

export default Transaction;
