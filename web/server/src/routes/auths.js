const router = require('express').Router();

const controller = require('../controllers/auths');
const { errorHandler } = require('../common/errorHandler');

router.get('/oauth/:service', errorHandler(controller.authByService));
router.get('/signIn/:service', errorHandler(controller.signInByService));

module.exports = router;
