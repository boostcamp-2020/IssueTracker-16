import React from 'react';
import styled from 'styled-components';

import ListHeader from '../common/ListHeader';

const Filter = styled.span`
  font-size: 10pt;
  margin-left: 5%;
`;
export default function IssueListHeader() {
  return (
    <ListHeader isIssueList={true}>
      <Filter>Author▾ </Filter>
      <Filter>Label▾ </Filter>
      <Filter>Milestone▾ </Filter>
      <Filter>Assignee▾ </Filter>
    </ListHeader>
  );
}
