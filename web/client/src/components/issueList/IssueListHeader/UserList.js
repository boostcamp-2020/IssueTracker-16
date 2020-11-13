import React, { useContext, useState, useEffect } from 'react';
import axios from 'axios';
import styled from 'styled-components';
import { useHistory, useLocation } from 'react-router-dom';

import COLOR from '../../../utils/color';
import {
  SearchInputContext,
  SetSearchInputContext,
  SetCheckItemsContext,
} from '../../../pages/IssueListPage';

const Wrapper = styled.div`
  display: flex;
  flex-direction: column;

  button {
    padding: 7px 30px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    border: none;
    border-top: 1px solid #${COLOR.lightGray};
    background-color: transparent;
    color: #${COLOR.black};
    outline: none;
    font-size: 12px;
    cursor: pointer;

    span {
      color: #${COLOR.darkGray};
      margin-left: 5px;
    }
  }
`;

const ProfileImage = styled.img`
  width: 20px;
  height: 20px;
  margin-right: 5px;
  border-radius: 50%;
  cursor: pointer;
`;

export default function UserList({ setIsOpen, type }) {
  const history = useHistory();
  const location = useLocation();
  const [users, setUsers] = useState([]);
  const searchInput = useContext(SearchInputContext);
  const setCheckItems = useContext(SetCheckItemsContext);
  const setSearchInput = useContext(SetSearchInputContext);

  const handleClickAuthor = (event, id) => {
    event.preventDefault();
    setCheckItems([]);
    setSearchInput(`is:open author:${id}`);
    setIsOpen(false);
    history.push(`/issues?isClosed=false&author=${id}`);
  };
  const handleClickAssignee = (event, id) => {
    event.preventDefault();
    setCheckItems([]);
    setSearchInput(`${searchInput} assignee:${id}`);
    setIsOpen(false);
    history.push(
      `/issues${
        location.search.length ? `${location.search}&` : '?'
      }label=${id}`,
    );
  };

  useEffect(() => {
    const getUsers = () => axios('/api/users');
    getUsers().then(({ data }) => setUsers(data));
  }, []);

  return (
    <Wrapper>
      {users.length ? (
        users.map(user => (
          <button
            key={user.num}
            onClick={event =>
              type === 'Author'
                ? handleClickAuthor(event, user.id)
                : handleClickAssignee(event, user.id)
            }
          >
            <ProfileImage src={user.imageUrl} />
            {user.id}
            <span>{user.name}</span>
          </button>
        ))
      ) : (
        <h3>We couldn’t find anything!</h3>
      )}
    </Wrapper>
  );
}
