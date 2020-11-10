const milestoneService = require('../services/milestones');
const { BAD_REQUEST, NOT_FOUND } = require('../common/errorHandler');
const { CREATED, OK } = require('../common/status');

const milestoneController = {
  add: async (req, res) => {
    const { title, dueDate, description } = req.body;
    if (isNaN(new Date(dueDate))) {
      throw new Error(BAD_REQUEST);
    }
    await milestoneService.add({ title, dueDate, description });
    res.status(CREATED).json({ success: true });
  },

  getAll: async (req, res) => {
    const isClosed = req.query.isClosed === 'true' ? true : false;
    const [milestones, total] = await Promise.all([
      milestoneService.findAll({ isClosed }),
      milestoneService.count(),
    ]);
    const count = milestones.length;
    const [open, closed] = isClosed
      ? [total - count, count]
      : [count, total - count];
    res.status(OK).json({ open, closed, milestones });
  },

  getOne: async (req, res) => {
    const { num } = req.params;
    const milestone = await milestoneService.findOneByNum({ num });
    if (!milestone) {
      throw new Error(NOT_FOUND);
    }
    res.status(OK).json(milestone);
  },

  update: async (req, res) => {
    const {
      params: { num },
      body: payload,
    } = req;

    if ('dueDate' in payload && isNaN(new Date(payload.dueDate))) {
      throw new Error(BAD_REQUEST);
    }

    const [updated] = await milestoneService.update({ num, payload });
    if (!updated) {
      throw new Error(NOT_FOUND);
    }
    res.status(OK).json({ success: true });
  },

  delete: async (req, res) => {
    const { num } = req.params;
    const deleted = await milestoneService.remove({ num });
    if (!deleted) {
      throw new Error(NOT_FOUND);
    }
    res.status(OK).json({ success: true });
  },
};

module.exports = milestoneController;
