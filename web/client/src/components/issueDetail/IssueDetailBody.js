import React from 'react';
import styled from 'styled-components';

import CommentList from './CommentList';
import CommentInput from './CommentInput';
import SideBar from './sideBar/SideBar';

const Div = styled.div`
  display: flex;

  > div:first-child {
    width: 100%;
  }
  > div:last-child {
    width: 300px;
  }
`;

export default function IssueDetailBody({
  comments,
  author,
  assignees,
  Milestone,
  labels,
  isClosed,
}) {
  return (
    <Div>
      <div className="left">
        <CommentList {...{ comments, author }} />
        <CommentInput {...{ isClosed }}></CommentInput>
      </div>
      <SideBar {...{ assignees, Milestone, labels }} />
    </Div>
  );
}
