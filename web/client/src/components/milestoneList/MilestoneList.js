import React, { useState, useEffect } from 'react';
import axios from 'axios';

import MilestoneListHeader from './MilestoneListHeader';
import MilestoneListBody from './MilestoneListBody';

export default function MilestoneList({ isClosed }) {
  const [states, setStates] = useState({
    open: 0,
    closed: 0,
    milestones: [],
  });

  useEffect(() => {
    const getIssues = () =>
      axios(`/api/milestones${isClosed ? '?isClosed=true' : ''}`);
    getIssues().then(({ data }) => setStates(data));
  }, [isClosed]);

  return (
    <div>
      <MilestoneListHeader {...states} />
      <MilestoneListBody {...states} />
    </div>
  );
}
