import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

const Div = styled.div``;
const Span = styled.span``;

export default function LinkButton({ name, url }) {
  return (
    <Div>
      <Link to={url}>
        <Span>name</Span>
      </Link>
    </Div>
  );
}
