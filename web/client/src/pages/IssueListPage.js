import React from 'react';
import IssueListNav from '../components/IssueListNav';
import IssueList from '../components/IssueList';

export default function IssueListPage() {
  return (
    <div>
      <IssueListNav />
      <br /> <br />
      <IssueList />
    </div>
  );
}
