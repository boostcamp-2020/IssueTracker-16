import React, { useEffect } from 'react';
import { Route, Redirect, useHistory, useLocation } from 'react-router-dom';

import { useAuth } from './ProvideAuth';

function PrivateRoute({ Component, ...rest }) {
  const history = useHistory();
  const location = useLocation();
  const { user, signIn } = useAuth();

  useEffect(() => {
    const { from } = location.state || { from: { pathname: '/' } };
    signIn(() => {
      history.replace(from);
    });
  }, []);

  const render = ({ location }) => {
    return user ? (
      <Component />
    ) : (
      <Redirect
        to={{
          pathname: '/signin',
          state: { from: location },
        }}
      />
    );
  };

  return <Route {...rest} render={render} />;
}

export default PrivateRoute;
