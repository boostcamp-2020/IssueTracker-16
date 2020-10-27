const { Model, DataTypes } = require('sequelize');
module.exports = class Assignee extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
      },
      {
        sequelize,
        timestamps: false,
        underscored: true,
        modelName: 'Assignee',
        tableName: 'assignees',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      }
    );
  }
  static associate({ Assignee, Issue, User }) {
    Assignee.belongsTo(Issue, {
      foreignKey: 'issue_num',
      targetKey: 'num',
    });
    Assignee.belongsTo(User, {
      foreignKey: 'user_num',
      targetKey: 'num',
    });
  }
};
