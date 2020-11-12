import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';

import ListPage from '../components/common/ListPage';
import Header from '../components/common/Header';
import IssueDetailHeader from '../components/issueDetail/IssueDetailHeader';
import IssueDetailBody from '../components/issueDetail/IssueDetailBody';

export default function IssueDetailPage() {
  const { num } = useParams();
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
