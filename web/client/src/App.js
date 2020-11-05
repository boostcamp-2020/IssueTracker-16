import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import NotFound from './pages/NotFound/NotFoundPage';
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
          <Route component={NotFound} />
        </Switch>
      </BrowserRouter>
    </>
  );
}
export default App;
