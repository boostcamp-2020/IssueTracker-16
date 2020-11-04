import React from 'react';
import styled from 'styled-components';

const LabelElement = styled.div`
  background-color: #${props => props.color};
  display: inline;
  padding: 3px 8px;
  border-radius: 20px;
  font-size: 10pt;
  font-weight: 600;
`;

export default function Label({ name, color }) {
  return <LabelElement color={color}>{name}</LabelElement>;
}
