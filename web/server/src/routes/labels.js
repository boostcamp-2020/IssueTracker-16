const router = require('express').Router();

const controller = require('../controllers/labels');
const { errorHandler } = require('../common/errorHandler');

router.post('', errorHandler(controller.add));
router.get('', controller.getAll);
router.get('/:num', controller.getOne);
router.put('/:num', controller.update);
router.delete('/:num', controller.delete);

module.exports = router;
