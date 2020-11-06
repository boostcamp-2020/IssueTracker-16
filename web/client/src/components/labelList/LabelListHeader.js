import React, { useState } from 'react';
import styled from 'styled-components';

const LabelListHeaderElement = styled.div`
  background-color: #fafbfc;
  border: 1px solid lightgrey;
  padding: 20px;
  font-weight: 600;
`;

export default function LabelListHeader() {
  return <LabelListHeaderElement>3 labels</LabelListHeaderElement>;
}
