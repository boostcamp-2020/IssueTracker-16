import React, { useState, useEffect } from 'react';
import axios from 'axios';

import IssueItem from './IssueItem';

export default function IssueListBody() {
  const [issues, setIssues] = useState([]);
  useEffect(() => {
    const getIssues = () => axios('/api/issues');
    getIssues().then(({ data }) => setIssues(data));
  }, []);

  return (
    <div>
      {!issues.length && <div>기다리는 중입니다...</div>}
      {issues.length &&
        issues.map(issue => <IssueItem key={issue.num} issue={issue} />)}
    </div>
  );
}
