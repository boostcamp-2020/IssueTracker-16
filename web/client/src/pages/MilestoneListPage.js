import React from 'react';
import MilestoneListNav from '../components/MilestoneListNav';
import MilestoneList from '../components/MilestoneList';

export default function MilestoneListPage() {
  return (
    <div className="milestone-list-page">
      <MilestoneListNav />
      <br /> <br />
      <MilestoneList />
    </div>
  );
}
