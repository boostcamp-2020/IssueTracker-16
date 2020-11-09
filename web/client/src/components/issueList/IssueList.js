import React, { useState, useEffect } from 'react';
import axios from 'axios';

import IssueListHeader from './IssueListHeader';
import IssueListBody from './IssueListBody';

export default function IssueList() {
  const [states, setStates] = useState({ open: 0, closed: 0, issues: [] });

  useEffect(() => {
    const getIssues = () => axios('/api/issues');
    getIssues().then(({ data }) => setStates(data));
  }, []);

  return (
    <div>
      <IssueListHeader {...states} />
      <IssueListBody {...states} />
    </div>
  );
}
