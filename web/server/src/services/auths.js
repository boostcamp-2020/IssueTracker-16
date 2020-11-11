const axios = require('axios');

const config = {
  gitHub: {
    codeUrl: 'https://github.com/login/oauth/authorize',
    accessTokenUrl: 'https://github.com/login/oauth/access_token',
    userInfoUrl: 'https://api.github.com/user',
    clientId: process.env.GITHUB_CLIENT_ID,
    clientSecret: process.env.GITHUB_CLIENT_SECRET,
    redirectUri: process.env.GITHUB_REDIRECT_URL,
    scope: 'read:user',
  },
};

const authService = {
  getCodeRequestUrl: ({ service }) => {
    const { codeUrl, clientId, redirectUri, scope } = config[service];
    const query = new URLSearchParams({
      client_id: clientId,
      redirect_uri: redirectUri,
      scope,
    }).toString();
    return `${codeUrl}?${query}`;
  },

  getAccessToken: async ({ service, code }) => {
    const { accessTokenUrl, clientId, clientSecret, redirectUri } = config[
      service
    ];
    const query = new URLSearchParams({
      client_id: clientId,
      client_secret: clientSecret,
      redirect_uri: redirectUri,
      code,
    }).toString();
    const { data: tokenData } = await axios.post(`${accessTokenUrl}?${query}`);
    return new URLSearchParams(tokenData).get('access_token');
  },

  getUserDataByAccessToken: async ({ service, accessToken }) => {
    const { userInfoUrl } = config[service];
    const {
      data: { login: id, name, avatar_url: imageUrl },
    } = await axios.get(userInfoUrl, {
      headers: {
        Authorization: `token ${accessToken}`,
      },
    });
    return { id, name, imageUrl };
  },

  getRedirectUrl: ({ userAgent, token }) => {
    const isMobile = /iphone|ipad|ipod|android/i.test(userAgent.toLowerCase());
    const iOSSchema = process.env.IOS_APP_SCHEMA;
    const webDomain = process.env.WEB_DOMAIN;
    return isMobile ? `${iOSSchema}?token=${token}` : webDomain;
  },
};

module.exports = authService;
