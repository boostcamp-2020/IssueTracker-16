import React from 'react';
import SearchBar from '../components/SearchBar';
import IssueList from '../components/IssueList';

export default function IssueListPage() {
  return (
    <div>
      <SearchBar />
      <button>Labels</button>
      <button>Milestones</button>
      <button>New Issue</button>
      <br /> <br />
      <IssueList />
    </div>
  );
}
