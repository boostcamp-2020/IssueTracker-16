import React, { createContext, useEffect, useState } from 'react';

import ListPage from '../components/common/ListPage';
import Header from '../components/common/Header';
import IssueListNav from '../components/issueList/IssueListNav/IssueListNav';
import IssueList from '../components/issueList/IssueList';

export const QueryContext = createContext({});
export const SearchInputContext = createContext('');
export const SetSearchInputContext = createContext(() => {});
export const CheckItemsContext = createContext([]);
export const SetCheckItemsContext = createContext(() => {});

export default function IssueListPage({ location }) {
  const [searchInput, setSearchInput] = useState('');
  const [checkItems, setCheckItems] = useState([]);
  const query = new URLSearchParams(location.search);
  let queryInput = '';
  for (const [key, value] of query) {
    queryInput += `${key}:${value} `;
  }
  queryInput = queryInput ? queryInput : 'is:open ';

  useEffect(() => {
    setSearchInput(queryInput);
  }, [queryInput]);

  return (
    <>
      <Header />
      <ListPage>
        <QueryContext.Provider value={query}>
          <SetCheckItemsContext.Provider value={setCheckItems}>
            <CheckItemsContext.Provider value={checkItems}>
              <SetSearchInputContext.Provider value={setSearchInput}>
                <SearchInputContext.Provider value={searchInput}>
                  <IssueListNav />
                  <IssueList />
                </SearchInputContext.Provider>
              </SetSearchInputContext.Provider>
            </CheckItemsContext.Provider>
          </SetCheckItemsContext.Provider>
        </QueryContext.Provider>
      </ListPage>
    </>
  );
}
