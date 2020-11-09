const router = require('express').Router();

const userRouter = require('./users');
const labelRouter = require('./labels');
const milestoneRouter = require('./milestones');
const issueRouter = require('./issues');
const commentRouter = require('./comments');
const labelingRouter = require('./labelings');

router.use('/users', userRouter);
router.use('/labels', labelRouter);
router.use('/milestones', milestoneRouter);
router.use('/issues', issueRouter);
router.use('/comments', commentRouter);
router.use('/labelings', labelingRouter);

module.exports = router;
