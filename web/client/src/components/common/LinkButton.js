import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

const Div = styled.div`
  margin: 2px;
  a {
    text-decoration: none;
    color: #000000;
  }
`;
const Span = styled.span`
  font-size: 12px;
`;

export default function LinkButton({ name, url }) {
  return (
    <Div>
      <Link to={url}>
        <Span>{name}</Span>
      </Link>
    </Div>
  );
}
