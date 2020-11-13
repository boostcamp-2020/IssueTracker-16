import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const Button = styled.button`
  height: 32px;
  padding: 5px 16px;
  background-color: #${({ isNotGreen }) => (isNotGreen ? COLOR.backGray : COLOR.green)};
  color: ${({ isNotGreen }) => (isNotGreen ? 'black' : 'white')};
  border: 1px solid #${({ isNotGreen }) => (isNotGreen ? COLOR.lightGray : '268841')};
  font-size: 14px;
  font-weight: 700;
  cursor: pointer;
  border-radius: 6px;
  outline: none;
  display: flex;

  &:hover {
    background-color: #${({ isNotGreen }) => (isNotGreen ? COLOR.lightGray : '2a9847')};
    border-color: #${({ isNotGreen }) => isNotGreen && 'bdbfbf'};
  }

  > svg {
    fill: #${COLOR.red};
    margin-right: 5px;
  }

  &:disabled {
    border: 1px solid #87c195;
    background-color: #94d3a2;
    cursor: default;
  }
`;

export default function GreenButton({
  children,
  disabled,
  onClick,
  isNotGreen,
}) {
  return <Button {...{ isNotGreen, onClick, disabled }}>{children}</Button>;
}
