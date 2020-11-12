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
  const isClosed = query.get('is') === 'closed';

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
      axios(`/api/issues${isClosed ? '?isClosed=true' : ''}`);
    getIssues().then(({ data }) => setStates(data));
  }, [isClosed]);

  return (
    <div>
      <CheckItemsContext.Provider value={checkItems}>
        <IssueListHeader {...{ ...states, handleAllCheck }} />
        <IssueListBody {...{ ...states, handleSingleCheck }} />
      </CheckItemsContext.Provider>
    </div>
  );
}
