import React from 'react';
import styled from 'styled-components';

const Button = styled.button`
  border: none;
  background-color: transparent;
  margin-right: 10px;
  outline: none;
  cursor: pointer;
`;

const Span = styled.span`
  font-size: 14px;
  color: #${({ color }) => color};
`;

export default function EventButton({ color, name, onClick }) {
  return (
    <Button>
      <Span {...{ color }} onClick={onClick}>
        {name}
      </Span>
    </Button>
  );
}
