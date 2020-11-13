import React from 'react';

import IssueItem from './IssueItem';
import ListBody from '../common/ListBody';
import NoResult from '../common/NoResult';
import OpenIssueLogo from '../../statics/svg/openIssue';

export default function IssueListBody({ issues, handleSingleCheck }) {
  return (
    <ListBody>
      {issues.length ? (
        issues.map(issue => (
          <IssueItem key={issue.num} {...{ ...issue, handleSingleCheck }} />
        ))
      ) : (
        <NoResult>
          <OpenIssueLogo />
          <h3>No results matched your search.</h3>
        </NoResult>
      )}
    </ListBody>
  );
}
