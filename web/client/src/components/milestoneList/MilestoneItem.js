import React from 'react';
import styled from 'styled-components';

import ListItem from '../common/ListItem';
import LinkButton from '../common/LinkButton';
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
const Buttons = styled.div`
  display: flex;
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
        <Buttons>
          <LinkButton name={'Edit'} url={'/'}></LinkButton>
          <LinkButton name={'Close'} url={'/'}></LinkButton>
          <LinkButton name={'Delete'} url={'/'}></LinkButton>
        </Buttons>
      </ItemElement>
    </ListItem>
  );
}
