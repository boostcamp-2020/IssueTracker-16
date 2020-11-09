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
      foreignKey: {
        name: 'issueNum',
        allowNull: false,
      },
      targetKey: 'num',
    });
    Comment.belongsTo(User, {
      foreignKey: {
        name: 'userNum',
        allowNull: false,
      },
      targetKey: 'num',
      as: 'writer',
    });
  }
};
