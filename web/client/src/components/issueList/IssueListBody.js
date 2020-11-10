import React from 'react';

import IssueItem from './IssueItem';
import ListBody from '../common/ListBody';

export default function IssueListBody({ issues }) {
  return (
    <ListBody>
      {!issues.length && <div>기다리는 중입니다...</div>}
      {issues.length &&
        issues.map(issue => <IssueItem key={issue.num} {...issue} />)}
    </ListBody>
  );
}
