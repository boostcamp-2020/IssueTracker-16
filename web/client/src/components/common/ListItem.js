import React from 'react';
import styled from 'styled-components';

const Li = styled.li`
  width: 100%;
  padding: 2% 2%;
  display: flex;
  justify-content: space-around;
  border: 0.1px solid #e0e0e0;
`;

export default function ListItem({ children }) {
  return <Li>{children}</Li>;
}
