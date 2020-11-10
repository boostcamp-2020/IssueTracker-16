import React from 'react';
import Helmet from 'react-helmet';
import queryString from 'query-string';

import ListPage from '../components/common/ListPage';

import Header from '../components/common/Header';
import MilestoneListNav from '../components/milestoneList/MilestoneListNav';
import MilestoneList from '../components/milestoneList/MilestoneList';

export default function MilestoneListPage({ location }) {
  const query = queryString.parse(location.search);
  const isClosed = query.is === 'closed';

  return (
    <>
      <Helmet>
        <title>Issue Tracker - Milestone</title>
      </Helmet>
      <Header />
      <ListPage>
        <MilestoneListNav />
        <MilestoneList {...{ isClosed }} />
      </ListPage>
    </>
  );
}
