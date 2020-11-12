import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const Div = styled.div`
  height: 300px;
  padding: 32px;
  margin-top: 60px;
  border: none;
  background-color: transparent;
  text-align: center;

  svg {
    width: 32px;
    height: 32px;
    fill: #${COLOR.darkGray};
  }

  h3 {
    margin-top: 30px;
    font-size: 20px;
    font-weight: 500;
    display: block;
  }
`;

export default function NoResult({ children }) {
  return <Div>{children}</Div>;
}
