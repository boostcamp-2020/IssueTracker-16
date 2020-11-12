import React from 'react';

import MilestoneItem from './MilestoneItem/MilestoneItem';
import ListBody from '../common/ListBody';

export default function MilestoneListBody({ milestones }) {
  return (
    <ListBody>
      {milestones.length &&
        milestones.map(milestone => (
          <MilestoneItem key={milestone.num} {...milestone} />
        ))}
    </ListBody>
  );
}
