import React from 'react';
import Helmet from 'react-helmet';

import Header from '../components/Header';
import MilestoneListNav from '../components/milestoneList/MilestoneListNav';
import MilestoneList from '../components/milestoneList/MilestoneList';

export default function MilestoneListPage() {
  return (
    <>
      <Helmet>
        <title>Issue Tracker - Milestone</title>
      </Helmet>
      <Header />
      <div>
        <MilestoneListNav />
        <br /> <br />
        <MilestoneList />
      </div>
    </>
  );
}
