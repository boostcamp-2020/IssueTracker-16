import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

import LabelLogo from '../../statics/svg/label';
import MilestoneLogo from '../../statics/svg/milestone';

const Nav = styled.nav`
  margin-left: auto;
  display: flex;
`;
const Span = styled.div`
  color: #000000;
`;
const TabButton = styled.button`
  border: 1px solid lightgrey;
  background-color: white;
  display: flex;
  font-size: 14px;
  font-weight: 600;
  padding: 7px 16px;

  &:first-child {
    border-top-left-radius: 6px;
    border-bottom-left-radius: 6px;
  }

  &:nth-child(2) {
    border-top-right-radius: 6px;
    border-bottom-right-radius: 6px;
    margin-left: -1px;
    margin-right: 15px;
  }

  &:hover {
    background-color: #fafbfc;
    cursor: pointer;
  }
`;

export default function LabelMilestoneNavigator() {
  const URL = {
    labels: '/labels',
    milestones: '/milestones',
  };
  return (
    <Nav>
      <TabButton>
        <LabelLogo />
        <Link to={URL.labels}>
          <Span>Labels</Span>
        </Link>
      </TabButton>
      <TabButton>
        <MilestoneLogo />
        <Link to={URL.milestones}>
          <Span>Milestones</Span>
        </Link>
      </TabButton>
    </Nav>
  );
}
