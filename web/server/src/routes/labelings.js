const router = require('express').Router();

const controller = require('../controllers/labelings');
const { errorHandler } = require('../common/errorHandler');

router.post('', errorHandler(controller.add));
router.delete(
  '/issue/:issueNum/label/:labelNum',
  errorHandler(controller.delete),
);

module.exports = router;
