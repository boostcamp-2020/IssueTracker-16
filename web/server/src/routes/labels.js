const router = require('express').Router();

const controller = require('../controllers/labels');
const { errorHandler } = require('../common/errorHandler');

router.post('', controller.add);
router.get('', controller.getAll);
router.get('/:num', errorHandler(controller.getOne));
router.put('/:num', errorHandler(controller.update));
router.delete('/:num', controller.delete);

module.exports = router;
