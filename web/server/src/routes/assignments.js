const router = require('express').Router();

const controller = require('../controllers/assignments');
const { errorHandler } = require('../common/errorHandler');

router.post('', errorHandler(controller.add));
router.delete(
  '/issue/:issueNum/user/:userNum',
  errorHandler(controller.delete),
);

module.exports = router;
