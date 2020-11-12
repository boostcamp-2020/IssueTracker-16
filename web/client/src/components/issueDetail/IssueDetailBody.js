import React from 'react';

import CommentList from './CommentList';
import CommentInput from './CommentInput';

export default function IssueDetailBody({
  comments,
  author,
  assignees,
  Milestone,
  labels,
  isClosed,
}) {
  return (
    <div>
      <div className="left">
        <CommentList {...{ comments, author }} />
        <CommentInput {...{ isClosed }}></CommentInput>
      </div>
      <div className="sidebar"></div>
    </div>
  );
}
