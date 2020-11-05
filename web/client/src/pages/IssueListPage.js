import React from 'react';

import Header from '../components/Header';
import IssueListNav from '../components/issueList/IssueListNav';
import IssueList from '../components/issueList/IssueList';

export default function IssueListPage() {
  return (
    <>
      <Header />
      <div>
        <IssueListNav />
        <IssueList />
      </div>
    </>
  );
}
