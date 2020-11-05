import React from 'react';
import styled from 'styled-components';

import RepositoryLogo from '../statics/svg/repository';

const HeaderElement = styled.header`
  background-color: #24292e;
  color: white;
  padding: 21.5px 0;
  font-size: 12pt;
  font-weight: 600;
  text-align: center;
  display: flex;
  justify-content: center;

  div {
    margin-left: 10px;
  }
`;

export default function Header() {
  return (
    <HeaderElement>
      <RepositoryLogo />
      <div>ISSUES</div>
    </HeaderElement>
  );
}
