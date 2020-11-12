import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

import COLOR from '../../../utils/color';

const Wrapper = styled.div`
  display: flex;
  flex-direction: column;

  a {
    padding: 7px 16px;
    border-top: 1px solid #${COLOR.lightGray};
    color: #${COLOR.black};
    text-decoration: none;
    font-size: 12px;
  }
`;

export default function FilterList({ setIsOpen, setSearchInput }) {
  const handleClickSelect = input => {
    setSearchInput(input);
    setIsOpen(false);
  };
  return (
    <Wrapper>
      <Link to={'/issues?is=open'} onClick={() => handleClickSelect('is:open')}>
        Open issues
      </Link>
      <Link
        to={'/issues?is=open+author=@me'}
        onClick={() => handleClickSelect('is:open author:@me')}
      >
        Your issues
      </Link>
      <Link
        to={'/issues?is=open+assignee=@me'}
        onClick={() => handleClickSelect('is:open assignee:@me')}
      >
        Everything assigned to you
      </Link>
      <Link
        to={'/issues?is=open+commenter=@me'}
        onClick={() => handleClickSelect('is:open commenter:@me')}
      >
        Everything commented by you
      </Link>
      <Link
        to={'/issues?is=closed'}
        onClick={() => handleClickSelect('is:closed')}
      >
        Closed Issues
      </Link>
    </Wrapper>
  );
}
