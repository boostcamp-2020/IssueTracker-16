const { Model, DataTypes } = require('sequelize');

module.exports = class Comment extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
        content: {
          type: DataTypes.TEXT,
          allowNull: false,
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
        modelName: 'Comment',
        tableName: 'comments',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      },
    );
  }
  static associate({ Comment, Issue, User }) {
    Comment.belongsTo(Issue, {
      foreignKey: 'issue_num',
      targetKey: 'num',
    });
    Comment.belongsTo(User, {
      foreignKey: 'user_num',
      targetKey: 'num',
      as: 'writer',
    });
  }
};
