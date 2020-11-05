import React from 'react';
import styled from 'styled-components';

import ListItem from '../common/ListItem';
import MilestoneProgress from './MilestoneProgress';

const ItemElement = styled.div`
  width: 48%;
`;
const Title = styled.div`
  font-size: 20pt;
`;
const Description = styled.div`
  font-size: 10pt;
  color: #959da5;
`;
const Button = styled.button`
  margin-right: 5px;
  border: none;
  outline: none;
  background-color: transparent;
  cursor: pointer;

  > a {
    color: ${props => (props.isDelete ? 'red' : 'blue')};
  }
`;

export default function MilestoneItem({
  title,
  dueDate,
  description,
  openedIssues,
  closedIssues,
}) {
  return (
    <ListItem>
      <ItemElement>
        <Title>{title}</Title>
        <Description>{dueDate}</Description>
        <Description>{description}</Description>
      </ItemElement>
      <ItemElement>
        <MilestoneProgress {...{ openedIssues, closedIssues }} />
        <div>
          <Button isDelete={false}>
            <a href="/">Edit</a>
          </Button>
          <Button isDelete={false}>
            <a href="/">Close</a>
          </Button>
          <Button isDelete={true}>
            <a href="/">Delete</a>
          </Button>
        </div>
      </ItemElement>
    </ListItem>
  );
}
