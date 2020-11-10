import React from 'react';
import styled from 'styled-components';

const Div = styled.div`
  height: 50px;
  padding: 10px 1%;
  margin: 0 auto;
  margin-top: 10px;
  display: flex;
  justify-content: ${props =>
    props.isIssueList ? 'space-between' : 'flex-start'};
  align-items: center;
  border: 0.1px solid #e0e0e0;
  border-radius: 10px 10px 0px 0px;
  background-color: #fafbfc;
`;

export default function ListHeader({ children, isIssueList }) {
  return <Div isIssueList={isIssueList}>{children}</Div>;
}
