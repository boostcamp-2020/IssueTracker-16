const axios = require('axios');

const authService = require('../services/auths');
// const userService = require('../services/users');
const { OK } = require('../common/status');

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

    // 1. access token 으로 유저 모델 조회
    // let user = await userService.getUser({ service, accessToken });

    // 2. 유저 모델이 없을 때
    // if (!user) {
    // 2-1. access token 으로 유저 정보 수집
    const userData = await authService.getUserDataByAccessToken({
      service,
      accessToken,
    });

    // 2-2. 수집한 유저 정보로 유저 모델 생성
    // user = await userService.createUser({ userData, service, accessToken });
    // }

    // 3. 유저 모델로 JWT 생성
    const { login: id, name, avatar_url: imageUrl } = userData;

    res.status(OK).json({ id, name, imageUrl });
  },
};

module.exports = authController;
