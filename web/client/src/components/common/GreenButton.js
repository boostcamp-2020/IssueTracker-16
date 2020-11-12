import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const Button = styled.button`
  height: 32px;
  padding: 5px 16px;
  background-color: #${COLOR.green};
  color: white;
  border: 1px solid #268841;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 6px;
  outline: none;

  &:hover {
    background-color: #2a9847;
  }
`;

export default function GreenButton({ children, onClick }) {
  return <Button onClick={onClick}>{children}</Button>;
}
