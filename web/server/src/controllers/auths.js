const authService = require('../services/auths');
const userService = require('../services/users');
const oAuthService = require('../services/oAuths');
const authorizationService = require('../services/authorization');
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

    if (!user) {
      const userData = await authService.getUserDataByAccessToken({
        service,
        accessToken,
      });

      user = await userService.join({ ...userData, password: accessToken });
      await authorizationService.add({
        userNum: user.num,
        oAuthNum: oAuth.num,
        accessToken,
      });
    }

    const token = await jwt.sign(user);
    res.cookie('token', token);

    const { ['user-agent']: userAgent } = req.headers;
    const redirectUrl = authService.getRedirectUrl({ userAgent, token });
    res.redirect(redirectUrl);
  },
};

module.exports = authController;
