import React from 'react';

import IssueItem from './IssueItem';
import ListBody from '../common/ListBody';

export default function IssueListBody({ issues, handleSingleCheck }) {
  return (
    <ListBody page={'issue'}>
      {issues.length &&
        issues.map(issue => (
          <IssueItem key={issue.num} {...{ ...issue, handleSingleCheck }} />
        ))}
    </ListBody>
  );
}
