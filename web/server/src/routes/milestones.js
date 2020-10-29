const router = require('express').Router();

const controller = require('../controllers/milestones');
const { errorHandler } = require('../common/errorHandler');

router.post('', errorHandler(controller.add));
router.get('', controller.getAll);
router.put('/:num', errorHandler(controller.update));
router.delete('/:num', errorHandler(controller.delete));

module.exports = router;
