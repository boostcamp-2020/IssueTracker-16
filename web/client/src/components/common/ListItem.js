import React from 'react';
import styled from 'styled-components';

const Li = styled.li``;

export default function ListItem({ children }) {
  return <Li>{children}</Li>;
}
