const { Model, DataTypes } = require('sequelize');

module.exports = class Issue extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
        title: {
          type: DataTypes.STRING,
          allowNull: false,
        },
        isClosed: {
          type: DataTypes.BOOLEAN,
          allowNull: false,
          defaultValue: false,
        },
        isDeleted: {
          type: DataTypes.BOOLEAN,
          allowNull: false,
          defaultValue: false,
        },
      },
      {
        sequelize,
        underscored: true,
        modelName: 'Issue',
        tableName: 'issues',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      },
    );
  }
  static associate({ Issue, Reply, Assignee, IssueLabel, Milestone, User }) {
    [Reply, Assignee, IssueLabel].forEach(model =>
      Issue.hasMany(model, {
        foreignKey: 'issue_num',
        sourceKey: 'num',
      }),
    );
    Issue.belongsTo(Milestone, {
      foreignKey: 'milestone_num',
      targetKey: 'num',
    });
    Issue.belongsTo(User, {
      foreignKey: 'user_num',
      targetKey: 'num',
    });
  }
};
