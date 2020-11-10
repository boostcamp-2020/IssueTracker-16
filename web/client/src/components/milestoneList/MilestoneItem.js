import React from 'react';
import styled from 'styled-components';

import ListItem from '../common/ListItem';
import MilestoneProgress from './MilestoneProgress';

const Link = styled.a`
  text-decoration: none;
`;
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
            <Link href="/">Edit</Link>
          </Button>
          <Button isDelete={false}>
            <Link href="/">Close</Link>
          </Button>
          <Button isDelete={true}>
            <Link href="/">Delete</Link>
          </Button>
        </div>
      </ItemElement>
    </ListItem>
  );
}
