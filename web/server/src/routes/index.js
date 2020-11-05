const router = require('express').Router();

const userRouter = require('./users');
const labelRouter = require('./labels');
const milestoneRouter = require('./milestones');
const issueRouter = require('./issues');

router.use('/users', userRouter);
router.use('/labels', labelRouter);
router.use('/milestones', milestoneRouter);
router.use('/issues', issueRouter);

module.exports = router;
