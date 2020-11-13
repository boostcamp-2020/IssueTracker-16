import React from 'react';
import styled from 'styled-components';

import AssigneesTap from './assignees/AssigneesTap';
import LabelsTap from './labels/LabelsTap';
import MilestonesTap from './milestones/MilestonesTap';

const Div = styled.div`
  margin-left: 15px;
`;

export default function SideBar({ assignees, labels, Milestone: milestone }) {
  return (
    <Div>
      <AssigneesTap {...{ assignees }} />
      <LabelsTap {...{ labels }} />
      <MilestonesTap {...{ milestone }} />
    </Div>
  );
}
