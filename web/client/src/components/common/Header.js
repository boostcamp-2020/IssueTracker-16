import React from 'react';
import { Link, useHistory } from 'react-router-dom';
import styled from 'styled-components';

import COLOR from '../../utils/color';
import RepositoryLogo from '../../statics/svg/repository';
import { useAuth } from '../../auth/ProvideAuth';

const HeaderElement = styled.header`
  position: relative;
  min-width: 700px;
  background-color: #24292e;
  color: white;
  padding: 21.5px 0;
  font-size: 12pt;
  font-weight: 600;
  text-align: center;
  display: flex;
  justify-content: center;

  a {
    display: flex;
    text-decoration: none;
  }

  span {
    margin-left: 5px;
    color: #${COLOR.white};
  }

  button {
    position: absolute;
    top: 15px;
    right: 10px;
    width: 80px;
    height: 30px;
    border: 1px solid #${COLOR.white};
    border-radius: 5px;
    color: #${COLOR.white};
    background-color: #24292e;
    font-size: 15px;
  }
`;

export default function Header() {
  const { signOut } = useAuth();
  const history = useHistory();
  const onSignOut = () => {
    signOut(() => history.push('/'));
  };
  return (
    <HeaderElement>
      <Link to={'/'}>
        <RepositoryLogo />
        <span>ISSUES</span>
      </Link>
      <button onClick={onSignOut}>Sign out</button>
    </HeaderElement>
  );
}
