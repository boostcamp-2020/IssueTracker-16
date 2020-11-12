import React, { useState, useEffect } from 'react';
import axios from 'axios';

import ListPage from '../components/common/ListPage';
import Header from '../components/common/Header';
import IssueDetailHeader from '../components/issueDetail/IssueDetailHeader';
import IssueDetailBody from '../components/issueDetail/IssueDetailBody';

export default function IssueDetailPage({ match }) {
  const { num } = match.params;
  const [issue, setIssue] = useState(null);

  useEffect(() => {
    axios(`/api/issues/${num}`).then(({ data }) => setIssue(data));
  }, [num]);
  return (
    <>
      <Header />
      <ListPage>
        {issue && (
          <>
            <IssueDetailHeader {...issue} />
            <IssueDetailBody {...issue} />
          </>
        )}
      </ListPage>
    </>
  );
}
