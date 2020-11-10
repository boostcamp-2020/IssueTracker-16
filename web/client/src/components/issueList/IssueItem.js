import React from 'react';
import styled from 'styled-components';

import Label from '../common/Label';
import ListItem from '../common/ListItem';

const ItemInfo = styled.div`
  width: 40%;
  display: flex;
  flex-direction: column;
`;
const Description = styled.div`
  font-size: 10pt;
  color: #959da5;
`;
const ItemTag = styled.div`
  width: 50%;
  display: flex;
`;
const LabelTag = styled.div`
  width: 50%;
`;
const AssigneeTag = styled.div`
  width: 50%;
`;
export default function IssueItem({
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
      <span>{isClosed ? 'X' : 'O'}</span>
      <ItemInfo>
        <span>{title} </span>
        <Description>
          <span>{author.id}</span>
          <span>{createdAt}</span>
          <span>{Milestone.title}</span>
        </Description>
      </ItemInfo>
      <ItemTag>
        <LabelTag>
          {labels.map(label => (
            <Label key={label.num} {...label} />
          ))}
        </LabelTag>
        <AssigneeTag>
          {assignees.map(a => (
            <div key={a.num}>{a.id}</div>
          ))}
        </AssigneeTag>
      </ItemTag>
    </ListItem>
  );
}
