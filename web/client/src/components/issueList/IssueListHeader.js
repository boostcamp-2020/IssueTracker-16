import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

import COLOR from '../../utils/color';
import ListHeader from '../common/ListHeader';
import OpenIssueLogo from '../../statics/svg/openIssue';
import CheckIcon from '../../statics/svg/checkIcon';

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
  font-size: 14px;
  padding: 8px;

  svg {
    margin-right: 5px;
  }

  a {
    display: flex;
    align-items: center;
    color: #${COLOR.black};
    text-decoration: none;
  }
`;

export default function IssueListHeader({ open, closed }) {
  return (
    <ListHeader isIssueList={true}>
      <Left>
        <Filter>
          <Link to={'/issues'}>
            <OpenIssueLogo />
            {open} Open{' '}
          </Link>
        </Filter>
        <Filter>
          <Link to={'/issues?isClosed=true'}>
            <CheckIcon />
            {closed} Closed{' '}
          </Link>
        </Filter>
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
