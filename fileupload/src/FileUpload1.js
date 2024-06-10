import React, { useCallback } from 'react';
import { useDropzone } from 'react-dropzone';

const FileUpload = () => {
  const onDrop = useCallback((acceptedFiles) => {
    // Do something with the files
    console.log(acceptedFiles);
  }, []);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({ onDrop });

  const handleFileInputChange = (event) => {
    const files = event.target.files;
    // Do something with the selected files
    console.log(files);
  };

  return (
    <div>
      <div {...getRootProps()} style={dropzoneStyles}>
        <input {...getInputProps()} />
        {
          isDragActive ?
            <p>Drop the files here ...</p> :
            <p>Drag 'n' drop some files here, or click to select files</p>
        }
      </div>
      <p>Or</p>
      <label htmlFor="fileInput" style={fileInputLabel}>
        Select Files
        <input id="fileInput" type="file" multiple style={{ display: 'none' }} onChange={handleFileInputChange} />
      </label>
    </div>
  );
};

const dropzoneStyles = {
  border: '2px dashed #cccccc',
  borderRadius: '4px',
  padding: '20px',
  textAlign: 'center',
  cursor: 'pointer',
};

const fileInputLabel = {
  cursor: 'pointer',
  display: 'inline-block',
  border: '2px solid #cccccc',
  borderRadius: '4px',
  padding: '10px 20px',
  backgroundColor: '#f0f0f0',
};

export default FileUpload;
