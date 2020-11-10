import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const Div = styled.div`
  height: 50px;
  margin: 0 auto;
  margin-top: 10px;
  padding: 8px;
  display: flex;
  justify-content: ${props =>
    props.isIssueList ? 'space-between' : 'flex-start'};
  align-items: center;
  border: 0.1px solid #${COLOR.lightGray};
  border-radius: 10px 10px 0px 0px;
  background-color: #fafbfc;
`;

export default function ListHeader({ children, isIssueList }) {
  return <Div isIssueList={isIssueList}>{children}</Div>;
}
