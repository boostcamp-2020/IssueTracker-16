import React from 'react';

import Header from '../components/common/Header';
import IssueListNav from '../components/issueList/IssueListNav';
import IssueList from '../components/issueList/IssueList';

export default function IssueListPage() {
  return (
    <>
      <Header />
      <IssueListNav />
      <IssueList />
    </>
  );
}
