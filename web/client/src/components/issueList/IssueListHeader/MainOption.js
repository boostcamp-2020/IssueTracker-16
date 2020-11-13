import React, { useContext } from 'react';
import styled from 'styled-components';
import { useHistory } from 'react-router-dom';

import COLOR from '../../../utils/color';
import OpenIssueLogo from '../../../statics/svg/openIssue';
import CheckIcon from '../../../statics/svg/checkIcon';
import { QueryContext } from '../../../pages/IssueListPage';
import FilterButton from './FilterButton';

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

    > div {
      margin-left: 16px;
    }
  }
`;

const OpenClosed = styled.div`
  font-size: 14px;

  svg {
    margin-right: 3px;
    fill: #${({ isClosed }) => (isClosed ? `${COLOR.black}` : `${COLOR.darkGray}`)};
  }

  button {
    display: flex;
    align-items: center;
    border: none;
    outline: none;
    background-color: transparent;
    color: #${({ isClosed }) => (isClosed ? `${COLOR.black}` : `${COLOR.darkGray}`)};
    cursor: pointer;
  }
`;

export default function MainOption({ open, closed }) {
  const history = useHistory();
  const query = useContext(QueryContext);
  const isClosed = query.get('is') === 'closed';

  const handleClickOpen = event => {
    event.preventDefault();
    query.set('is', 'open');
    history.push(`/issues?${query.toString()}`);
  };
  const handleClickClosed = event => {
    event.preventDefault();
    query.set('is', 'closed');
    history.push(`/issues?${query.toString()}`);
  };

  return (
    <>
      <Filters>
        <OpenClosed isClosed={!isClosed}>
          <button onClick={handleClickOpen}>
            <OpenIssueLogo />
            <span>{open} Open</span>
          </button>
        </OpenClosed>
        <OpenClosed isClosed={isClosed}>
          <button onClick={handleClickClosed}>
            <CheckIcon />
            <span>{closed} Closed</span>
          </button>
        </OpenClosed>
      </Filters>
      <Filters>
        <FilterButton type="Author" />
        <FilterButton type="Label" />
        <FilterButton type="Milestone" />
        <FilterButton type="Assignee" />
      </Filters>
    </>
  );
}
