import React from 'react';

import ListPage from '../components/common/ListPage';
import Header from '../components/common/Header';
import IssueListNav from '../components/issueList/IssueListNav';
import IssueList from '../components/issueList/IssueList';

export default function IssueListPage() {
  return (
    <>
      <Header />
      <ListPage>
        <IssueListNav />
        <IssueList />
      </ListPage>
    </>
  );
}
