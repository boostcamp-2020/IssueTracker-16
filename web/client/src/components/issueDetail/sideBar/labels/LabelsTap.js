import React, { useState } from 'react';
import styled from 'styled-components';

import COLOR from '../../../../utils/color';
import SideItem from '../SideItem';
import Popup from '../Popup';
import LabelEl from './LabelEl';
import LabelsPop from './LabelsPop';

const NothingItem = styled.div`
  font-size: 13px;
  cursor: pointer;
  &:hover {
    color: #${COLOR.blue};
  }
`;

export default function LabelsTap({ labels }) {
  const [state, setState] = useState({ isHidden: true });
  const title = 'Labels';
  const popTitle = 'Apply labels to this issue';

  const toggleState = () => setState({ isHidden: !state.isHidden });
  const onClick = () => toggleState();
  return (
    <SideItem {...{ title, onClick }}>
      <Popup {...{ popTitle, state }}>
        <LabelsPop {...{ labels }}></LabelsPop>
      </Popup>
      {(labels.length &&
        labels.map(label => <LabelEl key={label.num} {...label} />)) || (
        <NothingItem>None yet</NothingItem>
      )}
    </SideItem>
  );
}
