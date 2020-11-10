import React from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

import COLOR from '../../utils/color';
import RepositoryLogo from '../../statics/svg/repository';

const HeaderElement = styled.header`
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
`;

export default function Header() {
  return (
    <HeaderElement>
      <Link to={'/'}>
        <RepositoryLogo />
        <span>ISSUES</span>
      </Link>
    </HeaderElement>
  );
}
