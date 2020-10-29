const createHttpError = require('http-errors');

const errorMessages = {
  VALIDATION_ERROR: 'Validation error',
  BAD_REQUEST: 'Bad request',
  NO_CONTENTS: 'No contents',
};

const errorHandler = controller => async (req, res, next) =>
  await controller(req, res, next).catch(err => {
    let status;
    switch (err.message) {
      case errorMessages.BAD_REQUEST:
        status = 400;
        break;
      case errorMessages.NO_CONTENTS:
        status = 404;
        break;
      case errorMessages.VALIDATION_ERROR:
        status = 409;
        break;
      default:
        status = 500;
    }
    next(createHttpError(status, err.message));
  });

module.exports = {
  ...errorMessages,
  errorHandler,
};
