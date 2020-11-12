import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

import COLOR from '../../../utils/color';
import OpenIssueLogo from '../../../statics/svg/openIssue';
import CheckIcon from '../../../statics/svg/checkIcon';

const Filters = styled.div`
  display: flex;

  &:first-child {
    justify-content: flex-start;

    > span {
      margin-right: 10px;
    }
  }

  &:last-child {
    justify-content: flex-end;

    > span {
      margin-left: 16px;
    }
  }
`;
const Filter = styled.span`
  font-size: 14px;

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

export default function MainOption({ open, closed }) {
  return (
    <>
      <Filters>
        <Filter>
          <Link to={'/issues?is=open'}>
            <OpenIssueLogo />
            <span>{open} Open</span>
          </Link>
        </Filter>
        <Filter>
          <Link to={'/issues?is=closed'}>
            <CheckIcon />
            <span>{closed} Closed</span>
          </Link>
        </Filter>
      </Filters>
      <Filters>
        <Filter>Author▾ </Filter>
        <Filter>Label▾ </Filter>
        <Filter>Milestone▾ </Filter>
        <Filter>Assignee▾ </Filter>
      </Filters>
    </>
  );
}
