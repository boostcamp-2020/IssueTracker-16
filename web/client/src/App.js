import React from 'react';
import { BrowserRouter, Route } from 'react-router-dom';

import Header from './components/Header';
import IssueListPage from './pages/IssueListPage';
import LabelListPage from './pages/LabelListPage';
import MilestoneListPage from './pages/MilestoneListPage';

function App() {
  return (
    <div>
      <Header />
      <BrowserRouter>
        <Route exact path="/" component={IssueListPage} />
        <Route path="/labels" component={LabelListPage} />
        <Route path="/milestones" component={MilestoneListPage} />
      </BrowserRouter>
    </div>
  );
}
export default App;
