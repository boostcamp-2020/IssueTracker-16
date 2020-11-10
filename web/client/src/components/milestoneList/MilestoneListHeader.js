import React from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

import COLOR from '../../utils/color';
import ListHeader from '../common/ListHeader';
import MilestoneLogo from '../../statics/svg/milestone';
import CheckIcon from '../../statics/svg/checkIcon';

const Option = styled.span`
  font-size: 14px;
  margin-right: 10px;

  svg {
    margin-right: 3px;
  }

  a {
    display: flex;
    align-items: center;
    color: #${COLOR.black};
    text-decoration: none;
  }
`;
export default function MilestoneListHeader({ open, closed }) {
  return (
    <ListHeader isIssueList={false}>
      <Option>
        <Link to={'/milestones?is=open'}>
          <MilestoneLogo />
          {open} Open
        </Link>
      </Option>
      <Option>
        <Link to={'/milestones?is=closed'}>
          <CheckIcon />
          {closed} Closed
        </Link>
      </Option>
    </ListHeader>
  );
}
