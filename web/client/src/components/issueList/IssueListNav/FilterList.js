import React, { useContext } from 'react';
import styled from 'styled-components';
import { useHistory } from 'react-router-dom';

import COLOR from '../../../utils/color';
import {
  SetSearchInputContext,
  SetCheckItemsContext,
} from '../../../pages/IssueListPage';

const Wrapper = styled.div`
  display: flex;
  flex-direction: column;

  button {
    padding: 7px 16px;
    border: none;
    border-top: 1px solid #${COLOR.lightGray};
    background-color: transparent;
    color: #${COLOR.black};
    outline: none;
    font-size: 12px;
    cursor: pointer;
  }
`;

export default function FilterList({ setIsOpen }) {
  const history = useHistory();
  const setCheckItems = useContext(SetCheckItemsContext);
  const setSearchInput = useContext(SetSearchInputContext);

  const handleClickSelect = (event, input, query) => {
    event.preventDefault();
    setCheckItems([]);
    setSearchInput(input);
    setIsOpen(false);
    history.push(`/issues?${query}`);
  };
  return (
    <Wrapper>
      <button onClick={event => handleClickSelect(event, 'is:open', 'is=open')}>
        Open issues
      </button>
      <button
        onClick={event =>
          handleClickSelect(event, 'is:open author:@me', 'is=open&author=@me')
        }
      >
        Your issues
      </button>
      <button
        onClick={event =>
          handleClickSelect(
            event,
            'is:open assignee:@me',
            'is=open&assignee=@me',
          )
        }
      >
        Everything assigned to you
      </button>
      <button
        onClick={event => handleClickSelect(event, 'is:closed', 'is=closed')}
      >
        Closed Issues
      </button>
    </Wrapper>
  );
}
