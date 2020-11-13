import React, { useContext } from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

import COLOR from '../../../utils/color';
import OpenIssueLogo from '../../../statics/svg/openIssue';
import CheckIcon from '../../../statics/svg/checkIcon';
import { QueryContext } from '../../../pages/IssueListPage';

const Filters = styled.div`
  display: flex;

  &:first-child {
    justify-content: flex-start;

    > div {
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
`;

const OpenClosed = styled.div`
  font-size: 14px;

  svg {
    margin-right: 3px;
    fill: #${({ isClosed }) => (isClosed ? `${COLOR.black}` : `${COLOR.darkGray}`)};
  }

  a {
    display: flex;
    align-items: center;
    color: #${({ isClosed }) => (isClosed ? `${COLOR.black}` : `${COLOR.darkGray}`)};
    text-decoration: none;
  }
`;

export default function MainOption({ open, closed }) {
  const query = useContext(QueryContext);
  const isClosed = query.get('is') === 'closed';

  return (
    <>
      <Filters>
        <OpenClosed isClosed={!isClosed}>
          <Link to={'/issues?is=open'}>
            <OpenIssueLogo />
            <span>{open} Open</span>
          </Link>
        </OpenClosed>
        <OpenClosed isClosed={isClosed}>
          <Link to={'/issues?is=closed'}>
            <CheckIcon />
            <span>{closed} Closed</span>
          </Link>
        </OpenClosed>
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
