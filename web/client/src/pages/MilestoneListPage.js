import React from 'react';

import Header from '../components/Header';
import MilestoneListNav from '../components/milestoneList/MilestoneListNav';
import MilestoneList from '../components/milestoneList/MilestoneList';

export default function MilestoneListPage() {
  return (
    <>
      <Header />
      <div>
        <MilestoneListNav />
        <br /> <br />
        <MilestoneList />
      </div>
    </>
  );
}
