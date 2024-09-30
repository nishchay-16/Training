import axios from 'axios';

const API_URL = 'http://localhost:3000/api/v1/posts'; 

export const fetchPosts = async () => {
  const response = await axios.get(API_URL);
  return response.data;
};

export const createPost = async (postData) => {
  try {
    const response = await axios.post(API_URL, postData, {
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'), 
      },
    });
    return response.data;
  } catch (error) {
    console.error('Error creating post:', error.response ? error.response.data : error.message);
    throw error; 
  }
};
