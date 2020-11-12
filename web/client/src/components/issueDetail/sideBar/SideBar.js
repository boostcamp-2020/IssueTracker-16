import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import SideItem from './SideItem';
import Label from './Label';
import Milestone from './Milestone';
import AssigneesTap from './assignees/AssigneesTap';

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
  const state = { isHidden: true };
  const popTitle = 'title';
  const onClick = () => console.log('click');
  const Component = () => <div></div>;
  return (
    <Div>
      <AssigneesTap {...{ assignees }}></AssigneesTap>
      <SideItem {...{ title: 'Labels', onClick }}>
        {(labels.length &&
          labels.map(label => <Label key={label.num} {...label} />)) || (
          <NothingItem>None yet</NothingItem>
        )}
      </SideItem>
      <SideItem {...{ title: 'Milestone', onClick }}>
        {(milestone && <Milestone {...milestone} />) || (
          <NothingItem>No milestone</NothingItem>
        )}
      </SideItem>
    </Div>
  );
}
