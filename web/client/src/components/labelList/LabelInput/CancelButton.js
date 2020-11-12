import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';

const Cancel = styled.button`
  margin-right: 5px;
  padding: 5px 16px;
  background-color: #${COLOR.white};
  border: 1px solid #${COLOR.lightGray};
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 6px;
  outline: none;

  &:hover {
    background-color: #fafbfc;
  }
`;

export default function CancelButton({ setState }) {
  const toggleInput = event => {
    event.preventDefault();
    setState({ isHidden: true });
  };
  return <Cancel onClick={toggleInput}>Cancel</Cancel>;
}
