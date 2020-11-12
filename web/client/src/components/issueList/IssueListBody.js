import React from 'react';

import IssueItem from './IssueItem/IssueItem';
import ListBody from '../common/ListBody';
import NoResult from '../common/NoResult';
import OpenIssueLogo from '../../statics/svg/openIssue';

export default function IssueListBody({ issues }) {
  return (
    <ListBody>
      {issues.length ? (
        issues.map(issue => <IssueItem key={issue.num} {...issue} />)
      ) : (
        <NoResult>
          <OpenIssueLogo />
          <h3>No results matched your search.</h3>
        </NoResult>
      )}
    </ListBody>
  );
}
