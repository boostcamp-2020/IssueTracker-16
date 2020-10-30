const router = require('express').Router();

const userRouter = require('./users');
const labelRouter = require('./labels');
const milestoneRouter = require('./milestones');

router.use('/users', userRouter);
router.use('/labels', labelRouter);
router.use('/milestones', milestoneRouter);

module.exports = router;
