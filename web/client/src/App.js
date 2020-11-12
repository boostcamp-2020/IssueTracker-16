import React from 'react';
import { BrowserRouter, Route, Switch, Redirect } from 'react-router-dom';

import GlobalStyle from './GlobalStyle';
import ErrorPage from './pages/ErrorPage';
import IssueListPage from './pages/IssueListPage';
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
          <Route path="/signin" component={SignInPage} />
          <Route path="/error/:code" component={ErrorPage} />

          <PrivateRoute exact path="/">
            <IssueListPage />
          </PrivateRoute>
          <PrivateRoute path="/issues">
            <IssueListPage />
          </PrivateRoute>
          <PrivateRoute path="/labels">
            <LabelListPage />
          </PrivateRoute>
          <PrivateRoute path="/milestones">
            <MilestoneListPage />
          </PrivateRoute>

          <Redirect to="/error/404" />
        </Switch>
      </BrowserRouter>
    </>
  );
}

export default App;
