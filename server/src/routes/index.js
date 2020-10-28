const express = require('express');
const router = express.Router();
const userRouter = require('./users');

router.use('/users', userRouter);

router.use('/users', () => {
  console.log('wra');)
});

module.exports = router;
