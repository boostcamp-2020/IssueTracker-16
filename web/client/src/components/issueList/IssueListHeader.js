import React from 'react';
import styled from 'styled-components';

import ListHeader from '../common/ListHeader';

const Left = styled.div`
  width: 50%;
  display: flex;
  justify-content: flex-start;
`;
const Right = styled.div`
  width: 50%;
  display: flex;
  justify-content: flex-end;
`;
const Filter = styled.span`
  font-size: 10pt;
  margin-left: 5%;
`;

export default function IssueListHeader({ open, closed }) {
  return (
    <ListHeader isIssueList={true}>
      <Left>
        <Filter>{open} Open </Filter>
        <Filter>{closed} Closed </Filter>
      </Left>
      <Right>
        <Filter>Author▾ </Filter>
        <Filter>Label▾ </Filter>
        <Filter>Milestone▾ </Filter>
        <Filter>Assignee▾ </Filter>
      </Right>
    </ListHeader>
  );
}
