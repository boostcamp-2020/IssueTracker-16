import React, { useState } from 'react';
import styled from 'styled-components';

import COLOR from '../../../../utils/color';
import SideItem from '../SideItem';
import Popup from '../Popup';
import Assignee from './AssigneeEl';
import Assignees from './AssigneesPop';

const NothingItem = styled.div`
  font-size: 13px;
  cursor: pointer;
  &:hover {
    color: #${COLOR.blue};
  }
`;

export default function AssigneesTap({ assignees }) {
  const [state, setState] = useState({ isHidden: true });
  const title = 'Assignees';
  const popTitle = 'Assign up to someone this issue';

  const toggleState = () => setState({ isHidden: !state.isHidden });
  const onClick = () => toggleState();
  return (
    <SideItem {...{ title, onClick }}>
      <Popup {...{ popTitle, state }}>
        <Assignees {...{ assignees }} />
      </Popup>
      {(assignees.length &&
        assignees.map(assignee => (
          <Assignee key={assignee.num} {...assignee} />
        ))) || <NothingItem>No one--assign yourself</NothingItem>}
    </SideItem>
  );
}
