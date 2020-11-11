import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import isLightColor from '../../../utils/isLightColor';
import RefreshIcon from '../../../statics/svg/refreshIcon';

const Refresh = styled.button`
  min-width: 34px;
  margin-right: 8px;
  border: none;
  border-radius: 6px;
  background-color: #${({ color }) => color};
  outline: none;
  cursor: pointer;

  svg {
    margin: auto;
    fill: #${({ color }) => (isLightColor(color) ? COLOR.black : COLOR.white)};
  }
`;

export default function RefreshButton({ color, onClick }) {
  return (
    <Refresh {...{ color }} onClick={e => onClick(e)}>
      <RefreshIcon />
    </Refresh>
  );
}
