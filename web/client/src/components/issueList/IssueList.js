import React, { useState, useEffect } from 'react';
import axios from 'axios';

import IssueListHeader from './IssueListHeader';
import IssueListBody from './IssueListBody';

export default function IssueList({ isClosed }) {
  const [states, setStates] = useState({ open: 0, closed: 0, issues: [] });

  useEffect(() => {
    const getIssues = () =>
      axios(`/api/issues${isClosed ? '?isClosed=true' : ''}`);
    getIssues().then(({ data }) => setStates(data));
  }, [isClosed]);

  return (
    <div>
      <IssueListHeader {...states} />
      <IssueListBody {...states} />
    </div>
  );
}
