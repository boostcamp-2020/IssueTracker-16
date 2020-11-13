const router = require('express').Router();

const controller = require('../controllers/auths');
const { errorHandler } = require('../common/errorHandler');

router.get('/oauth/:service', errorHandler(controller.requestOAuthCode));
router.get('/signin/:service', errorHandler(controller.signInByOAuth));

module.exports = router;
