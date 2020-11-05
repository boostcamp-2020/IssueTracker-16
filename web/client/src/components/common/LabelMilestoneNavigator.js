import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

const Nav = styled.nav``;
const Span = styled.div``;

export default function LabelMilestoneNavigator() {
  const URL = {
    labels: '/labels',
    milestones: '/milestones',
  };
  return (
    <Nav>
      <Link to={URL.labels}>
        <Span>Labels</Span>
      </Link>
      <Link to={URL.milestones}>
        <Span>Milestones</Span>
      </Link>
    </Nav>
  );
}
