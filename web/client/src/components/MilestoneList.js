import React from 'react';
import MilestoneListHeader from './MilestoneListHeader';
import MilestoneListBody from './MilestoneListBody';

export default function MilestoneList() {
  return (
    <div className="milestone-list">
      <MilestoneListHeader />
      <MilestoneListBody />
    </div>
  );
}
