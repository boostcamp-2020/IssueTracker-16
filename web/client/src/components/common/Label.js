import React from 'react';
import styled from 'styled-components';

import isLightColor from '../../utils/isLightColor';
import COLOR from '../../utils/color';

const Div = styled.div`
  ${({ color }) => `
  background-color: #${color};
  color: #${isLightColor(color) ? COLOR.black : COLOR.white};
  `}
  line-height:${({ isLabelList }) => (isLabelList ? '22px' : '18px')};
  display: inline-block;
  padding: 0 7px;
  border: 1px solid transparent;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 540;
`;

export default function Label({ name, color, isLabelList }) {
  return <Div {...{ color, isLabelList }}>{name}</Div>;
}
