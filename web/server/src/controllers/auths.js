const authService = require('../services/auths');
const oAuthService = require('../services/oAuths');
const jwt = require('../common/jwt');

const authController = {
  requestOAuthCode: async (req, res) => {
    const { service } = req.params;
    const requestCodeURI = authService.getCodeRequestUrl({ service });
    res.redirect(requestCodeURI);
  },

  signInByOAuth: async (req, res) => {
    const { service } = req.params;
    const { code } = req.query;
    const accessToken = await authService.getAccessToken({ service, code });

    const oAuth = await oAuthService.findOne({ service });
    let [user] = await oAuth.getUsers({ accessToken });
    user =
      user || (await authService.joinUserByAccessToken({ oAuth, accessToken }));

    const token = await jwt.sign(user);
    res.cookie('token', token);
    const { from = '/' } = req.cookies;

    const { ['user-agent']: userAgent } = req.headers;
    const redirectUrl = authService.getRedirectUrl({ userAgent, token, from });
    res.redirect(redirectUrl);
  },
};

module.exports = authController;
