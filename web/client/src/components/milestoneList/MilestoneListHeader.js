import React from 'react';
import styled from 'styled-components';

import ListHeader from '../common/ListHeader';

const Option = styled.span`
  font-size: 10pt;
  margin-right: 5%;
`;
export default function MilestoneListHeader({ open, closed }) {
  return (
    <ListHeader isIssueList={false}>
      <Option>{open} Open </Option>
      <Option>{closed} Closed </Option>
    </ListHeader>
  );
}
