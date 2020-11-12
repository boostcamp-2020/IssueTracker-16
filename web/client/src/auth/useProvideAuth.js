import { useState } from 'react';
import axios from 'axios';

import cookies from '../utils/cookies';

function useProvideAuth() {
  const [user, setUser] = useState(null);

  const validateToken = async token => {
    if (!token) return false;
    const { data: success } = await axios.get(`/api/users/auth?token=${token}`);
    return success;
  };

  const signIn = async callback => {
    const { token } = cookies.getCookies('token');
    const isTokenValid = await validateToken(token);
    if (!isTokenValid) return;

    setUser({ token });
    callback?.();
  };

  const signOut = callback => {
    cookies.deleteCookie('token');
    setUser(null);
    callback?.();
  };

  return { user, signIn, signOut };
}

export default useProvideAuth;
