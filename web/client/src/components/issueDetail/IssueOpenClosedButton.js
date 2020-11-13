import React from 'react';
import axios from 'axios';

import GreenButton from '../common/GreenButton';
import ClosedIssueLogo from '../../statics/svg/closedIssue';

export default function CommentInput({ num, isClosed }) {
  const clickOpenCloseBtn = () => {
    axios
      .patch(`/api/issues/${num}`, { isClosed: !isClosed })
      .then(({ data }) => {
        if (data.success) {
          window.location = '';
        }
      })
      .catch(({ response }) => alert(response.data.message));
  };
  return (
    <GreenButton isNotGreen={true} onClick={clickOpenCloseBtn}>
      {isClosed ? (
        'Reopen issue'
      ) : (
        <>
          <ClosedIssueLogo />
          Close issue
        </>
      )}
    </GreenButton>
  );
}
