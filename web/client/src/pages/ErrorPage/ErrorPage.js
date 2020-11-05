import React from 'react';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet';

import './ErrorPage.scss';

export default function NotFoundPage({ match }) {
  const codes = ['404', '500'];
  let code = match.params.code;
  if (!codes.includes(code)) {
    window.location.href = '/error/404';
    code = 404;
  }
  return (
    <>
      <Helmet>
        <title>Error Page {code}</title>
      </Helmet>
      <div className="error-page">
        <div>
          <div className="error-message">
            <h1>{code}</h1>
          </div>
          <Link to="/" className="home-link">
            <span className="arrow"></span>Return To Homepage
          </Link>
        </div>
      </div>
    </>
  );
}
