import axios from 'axios';

const API_URL = 'http://localhost:3000/api/v1/posts'; 

export const fetchPosts = async () => {
  const response = await axios.get(API_URL);
  return response.data;
};

export const createPost = async (postData) => {
  try {
    // Try fetching the CSRF token from the meta tag
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
    
    const response = await axios.post(API_URL, postData, {
      headers: {
        'X-CSRF-Token': csrfToken || '', // Use an empty string if the token is not found
      },
    });
    return response.data; // Return the new post data
  } catch (error) {
    console.error('Error creating post:', error.response ? error.response.data : error.message);
    throw error; // Rethrow the error for handling in the calling function
  }
};

