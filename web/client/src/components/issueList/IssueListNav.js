import React from 'react';
import styled from 'styled-components';

import GreenButton from '../common/GreenButton';
import SearchBar from './SearchBar';
import LabelMilestoneNavigator from '../common/LabelMilestoneNavigator';
import ListNav from '../common/ListNav';

const Buttons = styled.div`
  margin-left: auto;
  display: flex;
`;

export default function IssueListNav() {
  return (
    <ListNav>
      <SearchBar />
      <Buttons>
        <LabelMilestoneNavigator />
        <GreenButton>New Issue</GreenButton>
      </Buttons>
    </ListNav>
  );
}
