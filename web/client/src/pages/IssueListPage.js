import React from 'react';
import styled from 'styled-components';

import Header from '../components/common/Header';
import IssueListNav from '../components/issueList/IssueListNav';
import IssueList from '../components/issueList/IssueList';

const IssueListPageElement = styled.div`
  width: 900px;
  margin: 0 auto;
`;

export default function IssueListPage() {
  return (
    <>
      <Header />
      <IssueListPageElement>
        <IssueListNav />
        <IssueList />
      </IssueListPageElement>
    </>
  );
}
