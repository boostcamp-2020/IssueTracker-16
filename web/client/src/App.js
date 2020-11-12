import React from 'react';
import { BrowserRouter, Route, Switch, Redirect } from 'react-router-dom';

import GlobalStyle from './GlobalStyle';
import ErrorPage from './pages/ErrorPage';
import IssueListPage from './pages/IssueListPage';
import IssueDetailPage from './pages/IssueDetailPage';
import LabelListPage from './pages/LabelListPage';
import MilestoneListPage from './pages/MilestoneListPage';
import SignInPage from './pages/SignInPage';
import PrivateRoute from './auth/PrivateRoute';

function App() {
  return (
    <>
      <GlobalStyle />
      <BrowserRouter>
        <Switch>
          <Route exact path="/signin" component={SignInPage} />
          <Route exact path="/error/:code" component={ErrorPage} />

          <PrivateRoute exact path="/">
            <IssueListPage />
          </PrivateRoute>
          <PrivateRoute exact path="/issues/:num">
            <IssueDetailPage />
          </PrivateRoute>
          <PrivateRoute exact path="/issues">
            <IssueListPage />
          </PrivateRoute>
          <PrivateRoute exact path="/labels">
            <LabelListPage />
          </PrivateRoute>
          <PrivateRoute exact path="/milestones">
            <MilestoneListPage />
          </PrivateRoute>

          <Redirect to="/error/404" />
        </Switch>
      </BrowserRouter>
    </>
  );
}

export default App;
