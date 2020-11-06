import React from 'react';
import styled from 'styled-components';

const Div = styled.div`
  display: flex;
  margin-top: 50px;

  div:last-child {
    margin-left: auto;
  }
`;

export default function ListPage({ children }) {
  return <Div>{children}</Div>;
}
