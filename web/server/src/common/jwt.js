const jwt = require('jsonwebtoken');

module.exports = {
  sign: user => {
    const secret = process.env.JWT_SECRET;
    return new Promise((resolve, reject) => {
      jwt.sign(
        {
          num: user.num,
          id: user.id,
        },
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
    });
  },
  authentication: {},
};
