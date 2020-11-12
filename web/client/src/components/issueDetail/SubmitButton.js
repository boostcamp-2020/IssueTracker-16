import React from 'react';
import axios from 'axios';

import GreenButton from '../common/GreenButton';

export default function CommentInput({ num, content }) {
  const clickComment = () => {
    axios
      .post('/api/comments', {
        content,
        issueNum: num,
      })
      .then(({ data }) => {
        if (data.success) {
          window.location = '';
        }
      })
      .catch(({ response }) => alert(response.data.message));
  };
  return (
    <GreenButton disabled={!content} onClick={clickComment}>
      Comment
    </GreenButton>
  );
}
