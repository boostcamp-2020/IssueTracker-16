import React from 'react';
import styled from 'styled-components';

const Ul = styled.ul`
  width: 80%;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
`;

export default function ListBody({ children }) {
  return <Ul>{children}</Ul>;
}
