const jwt = require('jsonwebtoken');

const { INVALID_TOKEN } = require('../common/errorHandler');
const secret = process.env.JWT_SECRET;

module.exports = {
  sign: ({ num, id }) =>
    new Promise((resolve, reject) => {
      jwt.sign(
        { num, id },
        secret,
        {
          expiresIn: '7d',
          issuer: 'issue_tracker_16',
          subject: 'userInfo',
        },
        (err, token) => {
          if (err) reject(err);
          resolve(token);
        },
      );
    }),

  authentication: token =>
    new Promise((resolve, reject) => {
      jwt.verify(token, secret, (err, decoded) => {
        if (err) reject(new Error(INVALID_TOKEN));
        resolve(decoded);
      });
    }),
};
