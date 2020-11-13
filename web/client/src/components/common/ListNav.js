import React from 'react';
import styled from 'styled-components';

const Div = styled.div`
  margin-bottom: 16px;
  display: flex;

  div:last-child {
    margin-left: auto;
  }
`;

export default function ListNav({ children }) {
  return <Div>{children}</Div>;
}
