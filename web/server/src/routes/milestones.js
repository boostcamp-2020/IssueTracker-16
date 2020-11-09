const router = require('express').Router();

const controller = require('../controllers/milestones');
const { errorHandler } = require('../common/errorHandler');

router.post('', errorHandler(controller.add));
router.get('', errorHandler(controller.getAll));
router.get('/:num', errorHandler(controller.getOne));
router.patch('/:num', errorHandler(controller.update));
router.delete('/:num', errorHandler(controller.delete));

module.exports = router;
