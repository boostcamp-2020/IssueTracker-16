import React, { useState, useEffect } from 'react';
import styled from 'styled-components';

import isLightColor from '../../utils/isLightColor';
import COLOR from '../../utils/color';

const Div = styled.div`
  ${({ color }) => `
  background-color: #${color};
  color: #${isLightColor(color) ? COLOR.black : COLOR.white};
  `}
  display: inline;
  padding: 3px 8px;
  border-radius: 20px;
  font-size: 10pt;
  font-weight: 600;
`;

export default function Label({ name, color }) {
  return <Div {...{ color }}>{name}</Div>;
}
