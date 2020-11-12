import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import SettingLogo from '../../../statics/svg/setting';

const Div = styled.div`
  border-bottom: 1px solid #${COLOR.lightGray};
  padding: 15px 0;
`;
const Title = styled.div`
  color: #${COLOR.darkGray};
  font-weight: 700;
  margin-bottom: 10px;
  display: flex;
  justify-content: space-between;
  cursor: pointer;
  font-size: 15px;

  svg {
    fill: #${COLOR.darkGray};
  }

  &:hover {
    color: #${COLOR.blue};
    svg {
      fill: #${COLOR.blue};
    }
  }
`;

export default function SideItem({ children, title }) {
  return (
    <Div>
      <Title>
        <div>{title}</div>
        <SettingLogo />
      </Title>
      {children}
    </Div>
  );
}
