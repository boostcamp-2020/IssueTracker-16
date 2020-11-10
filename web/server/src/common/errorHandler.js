const createHttpError = require('http-errors');

const {
  FORBIDDEN,
  BAD_REQUEST,
  NOT_FOUND,
  CONFLICT,
  INTERNAL_SERVER_ERROR,
} = require('../common/status');

const errorMessages = {
  BAD_REQUEST: 'Bad request',
  NOT_FOUND: 'Not found',
  VALIDATION_ERROR: 'Validation error',
  LOGIN_FAILED: 'Login failed',
};

const errorStatus = {
  [errorMessages.BAD_REQUEST]: BAD_REQUEST,
  [errorMessages.NOT_FOUND]: NOT_FOUND,
  [errorMessages.VALIDATION_ERROR]: CONFLICT,
  [errorMessages.LOGIN_FAILED]: FORBIDDEN,
};

const errorHandler = controller => async (req, res, next) =>
  await controller(req, res, next).catch(err => {
    const status = errorStatus[err.message];
    next(createHttpError(status || INTERNAL_SERVER_ERROR, err.message));
  });

module.exports = {
  ...errorMessages,
  errorHandler,
};
