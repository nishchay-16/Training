import React, { useState } from 'react';
import FileUpload from './FileUpload';

const App = () => {
  const [fileUploadVisible, setFileUploadVisible] = useState(false);

  const handleClick = () => {
    setFileUploadVisible(true);
  };

  return (
    <div style={{ backgroundColor: 'lightpink', height: '100vh' }}>
      {fileUploadVisible && <FileUpload />}
      <button onClick={handleClick}>Open File Upload</button>
    </div>
  );
};

export default App;
