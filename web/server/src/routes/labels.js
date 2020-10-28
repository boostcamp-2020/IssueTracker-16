const router = require('express').Router();

const controller = require('../controllers/labels');

// router.post(controller.add);
// router.get(controller.getAll);
router.get('/:num', controller.getOne);
// router.put('/:num', controller.update);
// router.delete('/:num', controller.delete);

module.exports = router;
