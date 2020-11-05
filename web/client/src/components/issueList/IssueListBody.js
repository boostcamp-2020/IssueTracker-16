import React, { useState, useEffect } from 'react';
import axios from 'axios';

import IssueItem from './IssueItem';
import ListBody from '../common/ListBody';

export default function IssueListBody() {
  const [issues, setIssues] = useState([]);
  useEffect(() => {
    const getIssues = () => axios('/api/issues');
    getIssues().then(({ data }) => setIssues(data));
  }, []);

  return (
    <ListBody>
      {!issues.length && <div>기다리는 중입니다...</div>}
      {issues.length &&
        issues.map(issue => <IssueItem key={issue.num} {...issue} />)}
    </ListBody>
  );
}
