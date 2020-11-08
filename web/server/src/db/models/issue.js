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
        modelName: 'issue',
        tableName: 'issues',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      },
    );
  }
  static associate({ Issue, Comment, Milestone, User, Label }) {
    Issue.hasMany(Comment, {
      foreignKey: 'issue_num',
      sourceKey: 'num',
      as: 'comments',
    });
    Issue.belongsTo(Milestone, {
      foreignKey: 'milestone_num',
      targetKey: 'num',
      as: 'milestone',
    });
    Issue.belongsTo(User, {
      foreignKey: 'user_num',
      targetKey: 'num',
      as: 'author',
    });
    Issue.belongsToMany(User, {
      foreignKey: 'issue_num',
      through: 'assignments',
      as: 'assignees',
      timestamps: false,
    });
    Issue.belongsToMany(Label, {
      foreignKey: 'issue_num',
      through: 'issues_labels',
      as: 'labels',
      timestamps: false,
    });
  }
};
