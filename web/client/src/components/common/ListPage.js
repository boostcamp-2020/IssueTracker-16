import React from 'react';
import styled from 'styled-components';

const Div = styled.div`
  width: 80%;
  min-width: 700px;
  margin: 50px auto;
`;

export default function ListPage({ children }) {
  return <Div>{children}</Div>;
}
