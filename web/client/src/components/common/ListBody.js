import React from 'react';
import styled from 'styled-components';

const Ul = styled.ul``;

export default function ListBody({ children }) {
  return <Ul>{children}</Ul>;
}
