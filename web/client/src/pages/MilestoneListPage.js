import React from 'react';
import MilestoneListNav from '../components/milestoneList/MilestoneListNav';
import MilestoneList from '../components/milestoneList/MilestoneList';

export default function MilestoneListPage() {
  return (
    <div>
      <MilestoneListNav />
      <br /> <br />
      <MilestoneList />
    </div>
  );
}
