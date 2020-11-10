import React from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

import COLOR from '../../utils/color';
import LabelLogo from '../../statics/svg/label';
import MilestoneLogo from '../../statics/svg/milestone';

const Nav = styled.nav`
  margin-left: auto;
  display: flex;
`;
const Span = styled.div`
  color: #${COLOR.black};
`;
const TabButton = styled.div`
  border: 1px solid lightgrey;
  background-color: white;
  display: flex;
  font-size: 14px;
  font-weight: 600;

  &:first-child {
    border-top-left-radius: 6px;
    border-bottom-left-radius: 6px;
  }

  &:last-child {
    border-top-right-radius: 6px;
    border-bottom-right-radius: 6px;
    margin-left: -1px;
    margin-right: 15px;
  }

  &:hover {
    background-color: #fafbfc;
    cursor: pointer;
  }

  a {
    padding: 7px 16px;
    display: flex;
    text-decoration: none;
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
        <Link to={URL.labels}>
          <LabelLogo />
          <Span>Labels</Span>
        </Link>
      </TabButton>
      <TabButton>
        <Link to={URL.milestones}>
          <MilestoneLogo />
          <Span>Milestones</Span>
        </Link>
      </TabButton>
    </Nav>
  );
}
