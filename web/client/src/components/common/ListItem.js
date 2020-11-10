import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const Li = styled.li`
  width: 100%;
  padding: 8px;
  display: flex;
  justify-content: space-between;
  border-top: 0.1px solid #${COLOR.lightGray};
`;

export default function ListItem({ children }) {
  return <Li>{children}</Li>;
}
