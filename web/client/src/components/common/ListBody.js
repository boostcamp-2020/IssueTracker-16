import React from 'react';
import styled from 'styled-components';

const Ul = styled.ul`
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
  border: 0.1px solid #e0e0e0;
  border-radius: 0px 0px 10px 10px;
`;

export default function ListBody({ children }) {
  return <Ul>{children}</Ul>;
}
