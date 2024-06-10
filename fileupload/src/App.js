import React, { useState } from 'react';
import FileUpload from './FileUpload';

const App = () => {
  const [fileUploadVisible, setFileUploadVisible] = useState(false);

  const handleClick = () => {
    setFileUploadVisible(true);
  };

  const handleClose = () => {
    setFileUploadVisible(false);
  };

  return (
    <div style={{ backgroundColor: 'lightpink', height: '100vh', position: 'relative' }}>
      {fileUploadVisible && (
        <>
          <div className="overlay" onClick={handleClose}></div>
          <FileUpload onClose={handleClose} />
        </>
      )}
      <button onClick={handleClick}>Open File Upload</button>
    </div>
  );
};

export default App;
