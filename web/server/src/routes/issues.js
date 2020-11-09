const router = require('express').Router();

const controller = require('../controllers/issues');
const { errorHandler } = require('../common/errorHandler');

router.get('', errorHandler(controller.getAll));
router.get('/:num', errorHandler(controller.getOne));
router.patch('/:num', errorHandler(controller.update));

module.exports = router;
