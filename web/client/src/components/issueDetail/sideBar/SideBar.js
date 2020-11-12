import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import SideItem from './SideItem';
import Assignee from './Assignee';
import Label from './Label';
import Milestone from './Milestone';

const Div = styled.div`
  margin-left: 15px;
`;

const NothingItem = styled.div`
  font-size: 13px;
  cursor: pointer;
  &:hover {
    color: #${COLOR.blue};
  }
`;

export default function SideBar({ assignees, labels, Milestone: milestone }) {
  return (
    <Div>
      <SideItem title="Assignees" {...assignees}>
        {(assignees.length &&
          assignees.map(assignee => (
            <Assignee key={assignee.num} {...assignee} />
          ))) || <NothingItem>No one--assign yourself</NothingItem>}
      </SideItem>
      <SideItem title="Labels">
        {(labels.length &&
          labels.map(label => <Label key={label.num} {...label} />)) || (
          <NothingItem>None yet</NothingItem>
        )}
      </SideItem>
      <SideItem title="Milestone">
        {(milestone && <Milestone {...milestone} />) || (
          <NothingItem>No milestone</NothingItem>
        )}
      </SideItem>
    </Div>
  );
}
