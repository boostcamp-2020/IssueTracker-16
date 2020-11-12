import React, { useState, useEffect, createContext, useContext } from 'react';
import axios from 'axios';

import IssueListHeader from './IssueListHeader/IssueListHeader';
import IssueListBody from './IssueListBody';
import { QueryContext } from '../../pages/IssueListPage';

export const CheckItemsContext = createContext([]);

export default function IssueList() {
  const [states, setStates] = useState({ open: 0, closed: 0, issues: [] });
  const [checkItems, setCheckItems] = useState([]);
  const query = useContext(QueryContext);

  const handleSingleCheck = (checked, num) => {
    if (checked) {
      setCheckItems([...checkItems, num]);
    } else {
      setCheckItems(checkItems.filter(item => item !== num));
    }
  };

  const handleAllCheck = checked => {
    if (checked) {
      setCheckItems(states.issues.map(issue => issue.num));
    } else {
      setCheckItems([]);
    }
  };

  useEffect(() => {
    const getIssues = () =>
      axios(
        `/api/issues${query.toString().length ? getQueryString(query) : ``}`,
      );
    getIssues().then(({ data }) => setStates(data));
  }, [query]);

  return (
    <div>
      <CheckItemsContext.Provider value={checkItems}>
        <IssueListHeader {...{ ...states, handleAllCheck }} />
        <IssueListBody {...{ ...states, handleSingleCheck }} />
      </CheckItemsContext.Provider>
    </div>
  );
}
const getQueryString = query => {
  const isClosed = query.get('is') === 'closed';
  let newQuery = `?isClosed=${isClosed}`;

  const author = query.get('author') === '@me' ? 'ahrimy' : query.get('author');
  newQuery += author ? `&author=${author}` : ``;

  const milestone = query.get('milestone');
  newQuery += milestone ? `&milestone=${milestone}` : ``;

  const label = query.getAll('label');
  newQuery += label.length
    ? label.reduce((str, l) => `${str}&label=${l}`, ``)
    : ``;

  const assignee = query.getAll('assignee');
  if (assignee.includes('@me')) {
    assignee[assignee.indexOf('@me')] = 'ahrimy';
  }
  newQuery += assignee.length
    ? assignee.reduce((str, a) => `${str}&assignee=${a}`, ``)
    : ``;

  return newQuery;
};
