import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const Ul = styled.ul`
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
  border: 0.1px solid #${COLOR.lightGray};
  border-radius: 0px 0px 10px 10px;
`;

export default function ListBody({ children }) {
  return <Ul>{children}</Ul>;
}
