import React from 'react';
import { BrowserRouter, Route, Switch, Redirect } from 'react-router-dom';

import GlobalStyle from './GlobalStyle';
import ErrorPage from './pages/ErrorPage';
import IssueListPage from './pages/IssueListPage';
import LabelListPage from './pages/LabelListPage';
import MilestoneListPage from './pages/MilestoneListPage';
import SignInPage from './pages/SignInPage';
import AuthPage from './pages/AuthPage';

function App() {
  return (
    <>
      <GlobalStyle />
      <BrowserRouter>
        <Switch>
          <Route exact path="/" component={IssueListPage} />
          <Route exact path="/signin" component={SignInPage} />
          <Route exact path="/auth/:service" component={AuthPage} />
          <Route exact path="/issues" component={IssueListPage} />
          <Route exact path="/labels" component={LabelListPage} />
          <Route exact path="/milestones" component={MilestoneListPage} />
          <Route exact path="/error/:code" component={ErrorPage} />
          <Redirect to="/error/404" />
        </Switch>
      </BrowserRouter>
    </>
  );
}
export default App;
