const router = require('express').Router();

const controller = require('../controllers/users');
const { errorHandler } = require('../common/errorHandler');

router.post('/login', errorHandler(controller.login));
router.post('/join', errorHandler(controller.join));
router.get('/auth', errorHandler(controller.auth));

module.exports = router;
