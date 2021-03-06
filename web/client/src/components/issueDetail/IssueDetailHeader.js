import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';
import getDiffTime from '../../utils/getDiffTime';
import OpenIssueLogo from '../../statics/svg/openIssue';
import ClosedIssueLogo from '../../statics/svg/closedIssue';
import IssueDetailTitle from './IssueDetailTitle';

const IssueDetailHeaderElement = styled.div`
  border-bottom: 2px solid #${COLOR.lightGray};
  padding-bottom: 15px;
  margin-bottom: 15px;
`;

const FlexHorizontalDiv = styled.div`
  margin-top: 5px;
  display: flex;
  align-items: center;

  > * {
    margin-right: 5px;
  }
`;

const Status = styled.div`
  display: flex;
  background-color: #${({ isClosed }) => (isClosed ? COLOR.red : COLOR.green)};
  color: white;
  padding: 7px 12px;
  border-radius: 20px;

  svg {
    fill: #${COLOR.white};
    margin-right: 5px;
  }
`;

const Description = styled.div`
  display: flex;
  align-items: center;

  > * {
    margin-right: 5px;
    color: #${COLOR.darkGray};
  }
`;

const Author = styled.div`
  font-weight: 700;
`;

export default function IssueDetailHeader({
  num,
  title,
  author,
  isClosed,
  createdAt,
  comments,
}) {
  return (
    <IssueDetailHeaderElement>
      <IssueDetailTitle {...{ num, title }} />
      <FlexHorizontalDiv>
        <Status {...{ isClosed }}>
          {isClosed ? (
            <>
              <ClosedIssueLogo />
              Closed
            </>
          ) : (
            <>
              <OpenIssueLogo />
              Open
            </>
          )}
        </Status>
        <Description>
          <Author>{author.id}</Author>
          <div>opened this issue</div>
          <div>{getDiffTime(createdAt)} · </div>
          <div>{comments.length} comments</div>
        </Description>
      </FlexHorizontalDiv>
    </IssueDetailHeaderElement>
  );
}
