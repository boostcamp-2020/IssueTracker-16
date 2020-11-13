import React, { useState } from 'react';
import styled from 'styled-components';

import SideItem from '../SideItem';
import Popup from '../Popup';
import MilestoneEl from './MilestoneEl';
import MilestonesPop from './MilestonesPop';

const NothingItem = styled.div`
  font-size: 13px;
`;

export default function MilestonesTap({ milestone }) {
  const [state, setState] = useState({ isHidden: true });
  const title = 'Milestone';
  const popTitle = 'Set milestone';

  const toggleState = () => setState({ isHidden: !state.isHidden });
  const onClick = () => toggleState();
  return (
    <SideItem {...{ title, onClick }}>
      <Popup {...{ popTitle, state }}>
        <MilestonesPop {...{ milestone }} />
      </Popup>
      {(milestone && <MilestoneEl {...milestone} />) || (
        <NothingItem>No milestone</NothingItem>
      )}
    </SideItem>
  );
}
