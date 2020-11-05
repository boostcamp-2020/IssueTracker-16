import React from 'react';
import styled from 'styled-components';

import LabelLogo from '../../statics/svg/label';
import MilestoneLogo from '../../statics/svg/milestone';

const LabelListNavElement = styled.div`
  display: flex;
  margin-top: 50px;

  div:last-child {
    margin-left: auto;
  }
`;

const GreenButton = styled.button`
  padding: 7px 16px;
  background-color: #2ea44f;
  color: white;
  border: 1px solid #268841;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 6px;

  &:hover {
    background-color: #2a9847;
  }
`;

const TabButton = styled.a`
  border: 1px solid lightgrey;
  background-color: white;
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

export default function LabelListNav() {
  return (
    <LabelListNavElement>
      <div>
        <TabButton>
          <LabelLogo />
          Labels
        </TabButton>
        <TabButton>
          <MilestoneLogo />
          Milestones
        </TabButton>
      </div>
      <div>
        <GreenButton>New Issue</GreenButton>
      </div>
    </LabelListNavElement>
  );
}
