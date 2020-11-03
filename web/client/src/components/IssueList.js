import React from 'react';
import IssueListHeader from './IssueListHeader';
import IssueItem from './IssueItem';

export default function Issue() {
  return (
    <div>
      <IssueListHeader />
      <br />
      <IssueItem />
      <IssueItem />
    </div>
  );
}
