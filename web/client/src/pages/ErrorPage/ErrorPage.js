import React from 'react';
import { Link } from 'react-router-dom';
import './ErrorPage.scss';

export default function NotFoundPage({ match }) {
  return (
    <div id="notfound">
      <div className="notfound">
        <div className="notfound-404">
          <h1>{match.params.code}</h1>
        </div>
        <Link to="/">
          <span className="arrow"></span>Return To Homepage
        </Link>
      </div>
    </div>
  );
}
