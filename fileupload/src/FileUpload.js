import React, { useCallback, useState } from 'react';
import { useDropzone } from 'react-dropzone';
import './FileUpload.css';

const FileUpload = () => {
  const [selectedFiles, setSelectedFiles] = useState([]);

  const onDrop = useCallback(acceptedFiles => {
    setSelectedFiles(prevFiles => [...prevFiles, ...acceptedFiles]);
  }, []);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({ onDrop });

  const handleUpload = () => {
    console.log("Files Uploaded:", selectedFiles);
    setSelectedFiles([]);
  };

  const handleFileClick = (file, event) => {
    event.stopPropagation();
    const fileURL = URL.createObjectURL(file);
    window.open(fileURL, '_blank');
  };

  const handleDeleteClick = (file, event) => {
    event.stopPropagation();
    const updatedFiles = selectedFiles.filter(f => f !== file);
    setSelectedFiles(updatedFiles);
  };

  return (
    <div className="file-upload">
      <h1>Create new Program/Policy</h1>
      <div>
        <h3 style={{ color: 'grey' }}>Title of HR Program/policy</h3>
        <input className='hr-input' type="text" />
      </div>
      <div>
        <h3 style={{ color: 'grey' }}>Upload File</h3>
        <div {...getRootProps()} className={`dropzone ${isDragActive ? 'active' : ''}`}>
        {isDragActive && (
          <div>
            <h1 style={{ fontSize: '40px', marginTop: '12px' }}>Drop it like it's hot</h1>
            <p style={{ marginTop: '-20px' }}>Upload files or folders by dropping them in this window</p>
          </div>
        )}
          <label className="upload-button">
            <i className="fa-solid fa-arrow-up-from-bracket upload-icon"></i>
            Upload File
          </label>
          <input {...getInputProps()} type="file" style={{ display: 'none' }} multiple />
        </div>
        
        <ul className="file-list">
          {selectedFiles.map(file => (
            <li key={file.name} className="file-item" onClick={(event) => handleFileClick(file, event)}>
              <span>{file.name}</span>
              <span className="file-size">{(file.size / 1024).toFixed(2)} KB</span>
              <button className="delete-button" onClick={(event) => handleDeleteClick(file, event)}>
                &#x2716;
              </button>
            </li>
          ))}
        </ul>
      </div>
      <div>
        <h3 style={{ color: 'grey' }}>Collaborate</h3>
        <input className='hr-input' type="text" />
      </div>
      <div>
        <button className="upload-button1" type="button" onClick={handleUpload} disabled={selectedFiles.length === 0}>
          Upload
        </button>
      </div>
    </div>
  );
};

export default FileUpload;
