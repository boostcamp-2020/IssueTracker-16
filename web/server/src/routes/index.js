const router = require('express').Router();

const userRouter = require('./users');
const labelRouter = require('./labels');

router.use('/users', userRouter);
router.use('/labels', labelRouter);

module.exports = router;
