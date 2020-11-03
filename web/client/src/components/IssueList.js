import React from 'react';
import IssueListHeader from './IssueListHeader';
import IssueItem from './IssueItem';

export default function Issue() {
  return (
    <>
      <IssueListHeader />
      <br />
      <IssueItem />
      <IssueItem />
    </>
  );
}
