import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import formatDate from '../../../utils/formatDate';
import ListItem from '../../common/ListItem';
import EventButton from '../../common/EventButton';
import MilestoneProgress from './MilestoneProgress';
import CalendarIcon from '../../../statics/svg/calendarIcon';
import DeleteButton from './DeleteButton';
import CloseButton from './CloseButton';

const ItemElement = styled.div`
  width: 48%;
`;
const Title = styled.div`
  font-size: 20pt;
`;
const DueDate = styled.div`
  font-size: 14px;
  margin-top: 5px;
  display: flex;
  color: #${COLOR.darkGray};
  svg {
    margin-right: 5px;
    fill: #${COLOR.darkGray};
  }
`;
const Description = styled.div`
  margin-top: 5px;
  font-size: 14px;
  color: #${COLOR.darkGray};
`;
const Buttons = styled.div`
  margin-top: 5px;
  display: flex;
  justify-content: flex-start;

  div {
    margin-right: 5px;
  }
`;

export default function MilestoneItem({
  num,
  title,
  dueDate,
  description,
  isClosed,
  openedIssues,
  closedIssues,
}) {
  return (
    <ListItem>
      <ItemElement>
        <Title>{title}</Title>
        <DueDate>
          {isClosed && <span>Closed</span>}
          {dueDate ? (
            <>
              <CalendarIcon />
              <span>Due by {formatDate(dueDate)}</span>
            </>
          ) : (
            <>
              <CalendarIcon />
              <span>No due date</span>
            </>
          )}
        </DueDate>
        {description && <Description>{description}</Description>}
      </ItemElement>
      <ItemElement>
        <MilestoneProgress {...{ openedIssues, closedIssues }} />
        <Buttons>
          <EventButton color={'0366d6'} name={'Edit'}></EventButton>
          <CloseButton {...{ num, isClosed }}></CloseButton>
          <DeleteButton {...{ num, isClosed }}></DeleteButton>
        </Buttons>
      </ItemElement>
    </ListItem>
  );
}
