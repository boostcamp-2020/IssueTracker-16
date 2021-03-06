const router = require('express').Router();

const controller = require('../controllers/comments');
const { errorHandler } = require('../common/errorHandler');

router.post('', errorHandler(controller.add));
router.put('/:num', errorHandler(controller.update));

module.exports = router;
