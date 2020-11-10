import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const Li = styled.li`
  min-height: 50px;
  width: 100%;
  padding: 8px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 0.1px solid #${COLOR.lightGray};
`;

export default function ListItem({ children }) {
  return <Li>{children}</Li>;
}
