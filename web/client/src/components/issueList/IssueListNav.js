import React from 'react';
import SearchBar from './SearchBar';

export default function IssueListNav() {
  return (
    <div>
      <SearchBar />
      <div>
        <button>Labels</button>
        <button>Milestones</button>
        <button>New Issue</button>
      </div>
    </div>
  );
}
