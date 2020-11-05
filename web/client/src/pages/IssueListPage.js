import React from 'react';

import IssueListNav from '../components/issueList/IssueListNav';
import IssueList from '../components/issueList/IssueList';

export default function IssueListPage() {
  return (
    <div>
      <IssueListNav />
      <IssueList />
    </div>
  );
}
