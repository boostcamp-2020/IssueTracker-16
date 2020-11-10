import React from 'react';
import styled from 'styled-components';

import getDiffTime from '../../utils/getDiffTime';

import Label from '../common/Label';
import ListItem from '../common/ListItem';
import MilestoneLogo from '../../statics/svg/milestone';
import OpenIssueLogo from '../../statics/svg/openIssue';
import ClosedIssueLogo from '../../statics/svg/closedIssue';

const ItemInfo = styled.div`
  margin: 0 5px;
  width: 100%;
`;
const Info = styled.div`
  display: flex;
  justify-content: flex-start;
`;
const Status = styled.div`
  svg {
    fill: #${({ isClosed }) => (isClosed ? 'd73a49' : '22863a')};
  }
`;
const Title = styled.div``;
const LabelTag = styled.div`
  display: flex;
`;
const AssigneeTag = styled.div``;
const Description = styled.div`
  margin-top: 4px;
  display: flex;
  font-size: 12px;
  color: #586069;

  > span {
    margin-right: 5px;
  }
`;
const MilestoneTag = styled.div`
  display: flex;
  align-items: center;

  svg {
    fill: #586069;
  }
  span {
    margin-left: 3px;
  }
`;
export default function IssueItem({
  num,
  title,
  author,
  labels,
  assignees,
  Milestone,
  isClosed,
  createdAt,
}) {
  return (
    <ListItem>
      <Status {...{ isClosed }}>
        {isClosed ? <ClosedIssueLogo /> : <OpenIssueLogo />}
      </Status>
      <ItemInfo>
        <Info>
          <Title>{title} </Title>
          <LabelTag>
            {labels.map(label => (
              <Label key={label.num} {...label} />
            ))}
          </LabelTag>
        </Info>
        <Description>
          <span>{`#${num} opened`}</span>
          <span>{getDiffTime(createdAt)}</span>
          <span>{`by ${author.id}`}</span>
          <MilestoneTag>
            <MilestoneLogo />
            <span>{Milestone.title}</span>
          </MilestoneTag>
        </Description>
      </ItemInfo>
      <AssigneeTag>
        {assignees.map(a => (
          <div key={a.num}>{a.id}</div>
        ))}
      </AssigneeTag>
    </ListItem>
  );
}
