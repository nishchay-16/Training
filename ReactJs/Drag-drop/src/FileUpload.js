import React, { useCallback, useEffect, useState } from 'react';
import { useDropzone } from 'react-dropzone';
import './FileUpload.css';

const FileUpload = ({ onClose }) => {
  const [selectedFiles, setSelectedFiles] = useState([]);
  const [dragActive, setDragActive] = useState(false);

  const onDrop = useCallback(acceptedFiles => {
    const filteredFiles = acceptedFiles.filter(file => file.size <= 1024 * 1024);
    const duplicateFiles = filteredFiles.filter(newFile =>
      selectedFiles.some(existingFile => existingFile.name === newFile.name)
    );
    if (duplicateFiles.length > 0) {
      alert("Cannot add multiple files with the same name.");
    } else {
      if (filteredFiles.length !== acceptedFiles.length) {
        alert("Files should not exceed the maximum size of 1 MB.");
      }
      setSelectedFiles(prevFiles => [...prevFiles, ...filteredFiles]);
    }
    setDragActive(false); // Close drop zone after files are dropped
  }, [selectedFiles]);

  const { getRootProps, getInputProps, open, isDragActive } = useDropzone({
    onDrop,
    noClick: true,
    onFileDialogCancel: () => setDragActive(false), // Close drop zone when file picker closes
  });

  useEffect(() => {
    const handleDragOver = (event) => {
      event.preventDefault();
      setDragActive(true);
    };

    const handleDragLeave = (event) => {
      // Only deactivate if leaving the entire window
      if (event.relatedTarget === null) {
        setDragActive(false);
      }
    };

    document.addEventListener('dragover', handleDragOver);
    document.addEventListener('dragleave', handleDragLeave);

    return () => {
      document.removeEventListener('dragover', handleDragOver);
      document.removeEventListener('dragleave', handleDragLeave);
    };
  }, []);

  const handleUpload = () => {
    console.log("Files Uploaded:", selectedFiles);
    setSelectedFiles([]);
    onClose();
  };

  const handleDeleteClick = (file, event) => {
    event.stopPropagation();
    const updatedFiles = selectedFiles.filter(f => f !== file);
    setSelectedFiles(updatedFiles);
  };

  return (
    <div className="file-upload-overlay">
      <div className="file-upload slide-in">
        <h1 style={{ fontFamily: "sans-serif" }}>Create new Program/Policy</h1>
        <div style={{ marginTop: '50px', fontFamily: "sans-serif" }}>
          <h3 style={{ color: 'grey', fontWeight: '550' }}>Title of HR Program/policy</h3>
          <input className='hr-input' type="text" style={{ width: '95%' }} />
        </div>
        <div style={{ width: '80%', marginTop: '50px', fontFamily: "sans-serif" }}>
          <h3 style={{ color: 'grey', fontWeight: '550' }}>Upload File</h3>
          {!dragActive && selectedFiles.length === 0 && (
            <button className="upload-button" onClick={open} >
              <div style={{ marginTop: '-2px' }}>
                <i className="fa-solid fa-arrow-up-from-bracket upload-icon"></i>
                Upload File
              </div>
            </button>
          )}
          {dragActive && (
            <div {...getRootProps()} className={`dropzone ${dragActive ? 'active' : ''}`}>
              <div>
                <h1 style={{ fontSize: '40px', marginTop: '12px' }}>Drop it like it's hot</h1>
                <p style={{ marginTop: '-20px' }}>Upload files or folders by dropping them in this window</p>
              </div>
              <input {...getInputProps()} type="file" style={{ display: 'none' }} multiple />
            </div>
          )}
          {!isDragActive && selectedFiles.length > 0 && (
            <ul className="file-list">
              {selectedFiles.map(file => (
                <li key={file.name} className="file-item" style={{ width: '115%' }}>
                  <div>
                    <span style={{ fontWeight: 'bold', fontSize: '16px' }}>{file.name}</span>
                    <div className="file-details" style={{ fontSize: '14px', color: "grey" }}>
                      {`${(file.size / 1024).toFixed(2)} KB | ${file.type}`}
                    </div>
                  </div>
                  <button className="delete-button" onClick={(event) => handleDeleteClick(file, event)}>
                    &#x2716;
                  </button>
                </li>
              ))}
              <li>
                <button style={{ border: 'none', padding: '8px', color: 'blue', fontWeight: 'bold' }} onClick={open}>
                  <i className="fa-solid fa-circle-plus"></i> Add more files
                </button>
                <input {...getInputProps()} type="file" style={{ display: 'none' }} multiple />
              </li>
            </ul>
          )}
        </div>
        <div style={{ marginTop: '65px', fontFamily: "sans-serif" }}>
          <h3 style={{ color: 'grey', fontWeight: '550' }}>Collaborate</h3>
          <h5 style={{ fontFamily: "sans-serif", color: 'grey', marginTop: '-12px' }}>Invite colleagues to contribute on the RFP</h5>
          <i className="fa-solid fa-magnifying-glass" style={{ position: 'absolute', fontSize: '20px', marginLeft: '10px', marginTop: '10px', color: '#606060' }} />
          <input className='hr-input' type="text" placeholder="Search for colleagues" style={{ paddingLeft: '40px', width: '91%' }} />
        </div>
        <div style={{ display: 'flex', justifyContent: 'flex-end', width: "100%", marginTop: "8%", marginLeft: "-3%" }}>
          <button className="upload-btn" type="button" onClick={handleUpload}>
            Save
          </button>
        </div>
      </div>
    </div>
  );
};

export default FileUpload;
