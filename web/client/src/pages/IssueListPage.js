import React from 'react';
import queryString from 'query-string';

import ListPage from '../components/common/ListPage';
import Header from '../components/common/Header';
import IssueListNav from '../components/issueList/IssueListNav';
import IssueList from '../components/issueList/IssueList';

export default function IssueListPage({ location }) {
  const query = queryString.parse(location.search);
  const isClosed = query.is === 'closed';

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
