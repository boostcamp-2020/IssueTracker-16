import React, { useState, useEffect } from 'react';
import axios from 'axios';

export default function AuthPage({ match, location }) {
  const [user, setUser] = useState();
  useEffect(() => {
    const { service } = match.params;
    const code = new URLSearchParams(location.search).get('code');

    // 예외 처리
    if (!service || !code) {
      window.location.href = '';
      return;
    }

    const signIn = async ({ service, code }) => {
      const { data: jwt } = await axios.get(
        `/api/auths/signIn/${service}?code=${code}`,
      );
      setUser(jwt);
    };
    signIn({ service, code });
  }, []);

  return (
    <>{!user ? '로그인 대기중 입니다...' : JSON.stringify(user, null, 2)}</>
  );
}
