import React from 'react';
import styled from 'styled-components';

import AssigneesTap from './assignees/AssigneesTap';
import LabelsTap from './labels/LabelsTap';

const Div = styled.div`
  margin-left: 15px;
`;

export default function SideBar({ assignees, labels, Milestone: milestone }) {
  return (
    <Div>
      <AssigneesTap {...{ assignees }}></AssigneesTap>
      <LabelsTap {...{ labels }}></LabelsTap>
      {/* <MilestoneTap {...{ milestone }}></MilestoneTap> */}
      {/*       
      <SideItem {...{ title: 'Milestone', onClick }}>
        {(milestone && <Milestone {...milestone} />) || (
          <NothingItem>No milestone</NothingItem>
        )}
      </SideItem> */}
    </Div>
  );
}
