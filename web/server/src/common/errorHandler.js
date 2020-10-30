const createHttpError = require('http-errors');

const errorMessages = {
  BAD_REQUEST: 'Bad request',
  NO_CONTENTS: 'No contents',
  VALIDATION_ERROR: 'Validation error',
};

const errorStatus = {
  [errorMessages.BAD_REQUEST]: 400,
  [errorMessages.NO_CONTENTS]: 404,
  [errorMessages.VALIDATION_ERROR]: 409,
};

const errorHandler = controller => async (req, res, next) =>
  await controller(req, res, next).catch(err => {
    const status = errorStatus[err.message];
    next(createHttpError(status || 500, err.message));
  });

module.exports = {
  ...errorMessages,
  errorHandler,
};
