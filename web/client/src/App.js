import React from 'react';
import { BrowserRouter, Route, Switch, Redirect } from 'react-router-dom';

import ErrorPage from './pages/ErrorPage/ErrorPage';
import IssueListPage from './pages/IssueListPage';
import LabelListPage from './pages/LabelListPage';
import MilestoneListPage from './pages/MilestoneListPage';

function App() {
  return (
    <>
      <BrowserRouter>
        <Switch>
          <Route exact path="/" component={IssueListPage} />
          <Route path="/issues" component={IssueListPage} />
          <Route path="/labels" component={LabelListPage} />
          <Route path="/milestones" component={MilestoneListPage} />
          <Route path="/error/:code" component={ErrorPage} />
          <Redirect to="/error/404" />
        </Switch>
      </BrowserRouter>
    </>
  );
}
export default App;
