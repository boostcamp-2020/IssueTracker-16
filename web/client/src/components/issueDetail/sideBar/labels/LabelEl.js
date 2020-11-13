import React from 'react';
import styled from 'styled-components';

import isLightColor from '../../../../utils/isLightColor';
import COLOR from '../../../../utils/color';

const Div = styled.div`
  font-size: 13px;
  padding: 3px;
  font-weight: 700;
  ${({ color }) => `
  background-color: #${color};
  color: #${isLightColor(color) ? COLOR.black : COLOR.white};
  `}
`;

export default function Label({ name, color }) {
  return <Div color={color}>{name}</Div>;
}
