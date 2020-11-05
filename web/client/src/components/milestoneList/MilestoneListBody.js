import React, { useState, useEffect } from 'react';
import axios from 'axios';

import MilestoneItem from './MilestoneItem';
import ListBody from '../common/ListBody';

export default function MilestoneListBody() {
  const [milestones, setMilestones] = useState([]);
  useEffect(() => {
    const getIssues = () => axios('/api/milestones');
    getIssues().then(({ data }) => setMilestones(data));
  }, []);

  return (
    <ListBody>
      {milestones.length &&
        milestones.map(milestone => (
          <MilestoneItem key={milestone.num} {...milestone} />
        ))}
    </ListBody>
  );
}
