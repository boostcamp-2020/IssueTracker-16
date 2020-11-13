import { useState } from 'react';
import axios from 'axios';

import cookies from '../utils/cookies';

function useProvideAuth() {
  const [user, setUser] = useState(null);

  const getUserByToken = async token => {
    if (!token) return false;
    const {
      data: { success, user },
    } = await axios.get(`/api/users/auth`);
    return success ? user : null;
  };

  const signIn = async callback => {
    const { token } = cookies.getCookies('token');
    const user = await getUserByToken(token);
    if (!user) return;

    setUser(user);
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
