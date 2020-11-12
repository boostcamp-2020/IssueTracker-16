import React from 'react';
import axios from 'axios';

import EventButton from '../../common/EventButton';

export default function DeleteButton({ num, isClosed }) {
  const deleteMilestone = num => axios.delete(`/api/milestones/${num}`);
  const handleClick = event => {
    event.preventDefault();
    if (window.confirm('Are you sure? Deletions are final!')) {
      deleteMilestone(num)
        .then(({ data }) => {
          if (data.success)
            window.location = `/milestones?${
              isClosed ? 'is=closed' : 'is=open'
            }`;
        })
        .catch(({ response }) => alert(response.data.message));
    }
  };
  return (
    <EventButton
      color={'cb2431'}
      name={'Delete'}
      onClick={handleClick}
    ></EventButton>
  );
}
