const labelService = require('../services/labels');
const { NOT_FOUND } = require('../common/errorHandler');
const { CREATED, OK } = require('../common/status');

const labelController = {
  add: async (req, res) => {
    const { name, color, description } = req.body;
    await labelService.add({ name, color, description });
    res.status(CREATED).json({ success: true });
  },

  getAll: async (req, res) => {
    const labels = await labelService.findAll();
    res.status(OK).json(labels);
  },

  getOne: async (req, res) => {
    const { num } = req.params;
    const label = await labelService.findOneByNum({ num });
    if (!label) {
      throw new Error(NOT_FOUND);
    }
    res.status(OK).json(label);
  },

  update: async (req, res) => {
    const {
      params: { num },
      body: payload,
    } = req;
    const [updated] = await labelService.update({ num, payload });
    if (!updated) {
      throw new Error(NOT_FOUND);
    }
    res.status(OK).json({ success: true });
  },

  delete: async (req, res) => {
    const { num } = req.params;
    const deleted = await labelService.remove({ num });
    if (!deleted) {
      throw new Error(NOT_FOUND);
    }
    res.status(OK).json({ success: true });
  },
};

module.exports = labelController;
