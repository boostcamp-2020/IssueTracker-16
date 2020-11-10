const axios = require('axios');

const config = {
  gitHub: {
    codeUrl: 'https://github.com/login/oauth/authorize',
    accessTokenUrl: 'https://github.com/login/oauth/access_token',
    userInfoUrl: 'https://api.github.com/user',
    client_id: process.env.GITHUB_CLIENT_ID,
    client_secret: process.env.GITHUB_CLIENT_SECRET,
    redirect_uri: process.env.GITHUB_REDIRECT_URL,
    scope: 'read:user',
  },
};

const authService = {
  getCodeRequestUrl: ({ service }) => {
    const { codeUrl, client_id, redirect_uri, scope } = config[service];
    const query = new URLSearchParams({
      client_id,
      redirect_uri,
      scope,
    }).toString();
    return `${codeUrl}?${query}`;
  },

  getAccessToken: async ({ service, code }) => {
    const { accessTokenUrl, client_id, client_secret, redirect_uri } = config[
      service
    ];
    const query = new URLSearchParams({
      client_id,
      client_secret,
      redirect_uri,
      code,
    }).toString();
    const { data: tokenData } = await axios.post(`${accessTokenUrl}?${query}`);
    return new URLSearchParams(tokenData).get('access_token');
  },

  getUserDataByAccessToken: async ({ service, accessToken }) => {
    const { userInfoUrl } = config[service];
    const { data: userData } = await axios.get(userInfoUrl, {
      headers: {
        Authorization: `token ${accessToken}`,
      },
    });
    return userData;
  },
};

module.exports = authService;
