import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const Li = styled.li`
  min-height: 50px;
  width: 100%;
  display: flex;
  justify-content: space-between;
  border-top: 0.1px solid #${COLOR.lightGray};

  > div {
    padding: 10px 0;

    &:first-child {
      padding-left: 16px;
    }
    &:last-child {
      padding-right: 16px;
    }
  }
  ${({ isIssue }) =>
    isIssue
      ? `&:hover {
            background-color: #fafbfc;
          }`
      : ''}
`;

export default function ListItem({ children, isIssue }) {
  return <Li {...{ isIssue }}>{children}</Li>;
}
