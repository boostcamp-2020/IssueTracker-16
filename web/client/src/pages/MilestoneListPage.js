import React from 'react';
import MilestoneListNav from '../components/MilestoneListNav';
import MilestoneList from '../components/MilestoneList';

export default function MilestoneListPage() {
  return (
    <div>
      <MilestoneListNav />
      <br /> <br />
      <MilestoneList />
    </div>
  );
}
