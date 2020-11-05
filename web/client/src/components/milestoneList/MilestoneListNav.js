import React from 'react';
import styled from 'styled-components';

import LabelMilestoneNavigator from '../common/LabelMilestoneNavigator';

const MilestoneListNavElement = styled.div`
  width: 80%;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  margin-top: 50px;
`;

const GreenButton = styled.button`
  padding: 7px 16px;
  background-color: #2ea44f;
  color: white;
  border: 1px solid #268841;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 6px;

  &:hover {
    background-color: #2a9847;
  }
`;
export default function MilestoneListNav() {
  return (
    <MilestoneListNavElement>
      <div>
        <LabelMilestoneNavigator />
      </div>
      <GreenButton>New Milestone</GreenButton>
    </MilestoneListNavElement>
  );
}
