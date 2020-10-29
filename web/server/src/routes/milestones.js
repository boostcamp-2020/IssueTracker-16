const router = require('express').Router();

const controller = require('../controllers/milestones');
const { errorHandler } = require('../common/errorHandler');

router.post('', controller.add);
router.get('', controller.getAll);
router.put('/:num', controller.update);
router.delete('/:num', controller.delete);

module.exports = router;
