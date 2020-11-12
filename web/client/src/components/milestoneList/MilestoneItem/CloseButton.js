import React from 'react';
import axios from 'axios';

import EventButton from '../../common/EventButton';

export default function CloseButton({ num, isClosed }) {
  const closeMilestone = (num, body) =>
    axios.patch(`/api/milestones/${num}`, body);

  const handleClick = event => {
    event.preventDefault();

    closeMilestone(num, { isClosed: !isClosed })
      .then(({ data }) => {
        if (data.success)
          window.location = `/milestones?${isClosed ? 'is=closed' : 'is=open'}`;
      })
      .catch(({ response }) => alert(response.data.message));
  };
  return (
    <EventButton
      color={'0366d6'}
      name={isClosed ? 'Reopen' : 'Close'}
      onClick={handleClick}
    ></EventButton>
  );
}
