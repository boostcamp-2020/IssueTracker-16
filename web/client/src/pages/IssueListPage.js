import React, { createContext, useState } from 'react';
import { useLocation } from 'react-router-dom';

import ListPage from '../components/common/ListPage';
import Header from '../components/common/Header';
import IssueListNav from '../components/issueList/IssueListNav/IssueListNav';
import IssueList from '../components/issueList/IssueList';

export const QueryContext = createContext({});
export const SearchInputContext = createContext('');
export const SetSearchInputContext = createContext(() => {});

export default function IssueListPage() {
  const location = useLocation();
  const query = new URLSearchParams(location.search);

  let queryInput = '';
  for (const [key, value] of query) {
    queryInput += `${key}:${value} `;
  }
  queryInput = queryInput ? queryInput : 'is:open ';

  const [searchInput, setSearchInput] = useState(queryInput);

  return (
    <>
      <Header />
      <ListPage>
        <QueryContext.Provider value={query}>
          <SetSearchInputContext.Provider value={setSearchInput}>
            <SearchInputContext.Provider value={searchInput}>
              <IssueListNav />
            </SearchInputContext.Provider>
          </SetSearchInputContext.Provider>
          <IssueList />
        </QueryContext.Provider>
      </ListPage>
    </>
  );
}
