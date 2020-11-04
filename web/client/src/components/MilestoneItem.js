import React from 'react';
import MilestoneProgress from './MilestoneProgress';

export default function MilestoneItem() {
  return (
    <div className="milestone-item">
      <div>
        <div>[Title]</div>
        <div>[Due date]</div>
        <div>[description]</div>
      </div>
      <div>
        <MilestoneProgress />
        <div>
          <button>Edit</button>
          <button>Close</button>
          <button>Delete</button>
        </div>
      </div>
    </div>
  );
}
