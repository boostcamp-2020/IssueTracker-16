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
const Span = styled.span`
  color: #${COLOR.black};
`;
const TabButton = styled.div`
  height: 32px;
  ${({ isSelected }) =>
    isSelected
      ? `border: 1px solid #0366d6;
         background-color: #0366d6;
         svg {
          fill: #${COLOR.white}
         }
         span {
           color: #${COLOR.white}
         }`
      : `border: 1px solid lightgrey;
         background-color: #${COLOR.white};
         &:hover {
          background-color: #fafbfc;
          cursor: pointer;
        }`}
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

  svg {
    margin-right: 2px;
  }

  a {
    padding: 7px 16px;
    display: flex;
    text-decoration: none;
  }
`;

export default function LabelMilestoneNavigator({ page }) {
  const isLabel = page === 'label';
  const isMilestone = page === 'milestone';
  const URL = {
    labels: '/labels',
    milestones: '/milestones',
  };
  return (
    <Nav>
      <TabButton isSelected={isLabel}>
        <Link to={URL.labels}>
          <LabelLogo />
          <Span>Labels</Span>
        </Link>
      </TabButton>
      <TabButton isSelected={isMilestone}>
        <Link to={URL.milestones}>
          <MilestoneLogo />
          <Span>Milestones</Span>
        </Link>
      </TabButton>
    </Nav>
  );
}
