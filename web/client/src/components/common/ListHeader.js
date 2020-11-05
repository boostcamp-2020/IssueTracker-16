import React from 'react';
import styled from 'styled-components';

const Div = styled.div`
  width: 80%;
  padding: 2% 1%;
  margin: 0 auto;
  border: 0.1px solid #e0e0e0;
  background-color: #c0c0c0;
`;

export default function ListHeader({ children }) {
  return <Div>{children}</Div>;
}
