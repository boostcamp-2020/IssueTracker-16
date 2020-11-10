import React from 'react';
import Helmet from 'react-helmet';

import ListPage from '../components/common/ListPage';

import Header from '../components/common/Header';
import MilestoneListNav from '../components/milestoneList/MilestoneListNav';
import MilestoneList from '../components/milestoneList/MilestoneList';

export default function MilestoneListPage() {
  return (
    <>
      <Helmet>
        <title>Issue Tracker - Milestone</title>
      </Helmet>
      <Header />
      <ListPage>
        <MilestoneListNav />
        <br /> <br />
        <MilestoneList />
      </ListPage>
    </>
  );
}
