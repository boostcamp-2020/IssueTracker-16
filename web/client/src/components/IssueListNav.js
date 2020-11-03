import React from 'react';
import SearchBar from './SearchBar';

export default function IssueListNav() {
  return (
    <div>
      <SearchBar />
      <button>Labels</button>
      <button>Milestones</button>
      <button>New Issue</button>
    </div>
  );
}
