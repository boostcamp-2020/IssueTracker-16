import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';

const Cancel = styled.button`
  margin-right: 5px;
  padding: 5px 16px;
  background-color: #${COLOR.lightGray};
  border: 1px solid #${COLOR.darkGray};
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 6px;

  &:hover {
    background-color: #fafbfc;
  }
`;

export default function CancelButton() {
  return <Cancel>Cancel</Cancel>;
}
