import React from 'react';
import styled from 'styled-components';

import SearchBar from './SearchBar';
import LabelMilestoneNavigator from '../common/LabelMilestoneNavigator';

const IssueListNavElement = styled.div`
  width: 80%;
  margin: 0 auto;
  display: flex;
  margin-top: 50px;
`;

const Buttons = styled.div`
  margin-left: auto;
  display: flex;
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

export default function IssueListNav() {
  return (
    <IssueListNavElement>
      <SearchBar />
      <Buttons>
        <LabelMilestoneNavigator />
        <GreenButton>New Issue</GreenButton>
      </Buttons>
    </IssueListNavElement>
  );
}
