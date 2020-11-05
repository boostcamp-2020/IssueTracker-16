import React from 'react';
import styled from 'styled-components';

import ListHeader from '../common/ListHeader';

const Option = styled.span`
  font-size: 10pt;
  margin-right: 5%;
`;
export default function MilestoneListHeader() {
  return (
    <ListHeader isIssueList={false}>
      <Option>✔︎Open </Option>
      <Option>✔︎Closed </Option>
    </ListHeader>
  );
}
