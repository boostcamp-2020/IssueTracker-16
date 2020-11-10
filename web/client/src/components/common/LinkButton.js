import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

const Div = styled.div`
  a {
    text-decoration: none;
    color: #000000;
  }
`;
const Span = styled.span`
  font-size: 14px;
  color: #${({ color }) => color};
`;

export default function LinkButton({ color, name, url }) {
  return (
    <Div>
      <Link to={url}>
        <Span {...{ color }}>{name}</Span>
      </Link>
    </Div>
  );
}
