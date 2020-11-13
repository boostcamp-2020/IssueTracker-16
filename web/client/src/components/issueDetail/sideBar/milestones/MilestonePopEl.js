import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../../utils/color';
import CheckIcon from '../../../../statics/svg/checkIcon';
import formatDate from '../../../../utils/formatDate';
import CalendarIcon from '../../../../statics/svg/calendarIcon';

const Div = styled.div`
  padding: 5px 0;
  border-bottom: 1px solid #${COLOR.lightGray};
  background-color: white;
  cursor: pointer;
  > div {
    color: #${COLOR.darkGray};
  }
  &:hover {
    background-color: #${COLOR.blue};
    > div {
      color: white;
    }
    svg {
      fill: white;
    }
  }
`;

const Milestone = styled.div`
  display: flex;
  align-items: center;
`;

const Check = styled.div`
  margin-left: 5px;
  width: 20px;
`;

const Name = styled.div`
  margin-left: 5px;
  font-size: 14px;
  ${props => props.isChecked && `font-weight: 700;`}
`;

const DueDate = styled.div`
  display: flex;
  margin-left: 30px;
  font-size: 13px;
  margin-top: 3px;
  svg {
    fill: #${COLOR.darkGray};
    margin-right: 5px;
  }
`;

export default function MilestonePopEl({ num, title, dueDate, isChecked }) {
  return (
    <Div>
      <Milestone>
        <Check>{isChecked && <CheckIcon />}</Check>
        <Name isChecked={isChecked}>{title}</Name>
      </Milestone>
      <DueDate>
        {dueDate ? (
          <>
            <CalendarIcon />
            <span>Due by {formatDate(dueDate)}</span>
          </>
        ) : (
          <span>No due date</span>
        )}
      </DueDate>
    </Div>
  );
}
