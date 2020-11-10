import React from 'react';

import ListPage from '../components/common/ListPage';
import Header from '../components/common/Header';
import IssueListNav from '../components/issueList/IssueListNav';
import IssueList from '../components/issueList/IssueList';

export default function IssueListPage({ location }) {
  const query = new URLSearchParams(location.search);
  const isClosed = query.get('is') === 'closed';

  return (
    <>
      <Header />
      <ListPage>
        <IssueListNav />
        <IssueList {...{ isClosed }} />
      </ListPage>
    </>
  );
}
