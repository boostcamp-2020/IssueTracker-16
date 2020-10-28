const { Model, DataTypes } = require('sequelize');

module.exports = class Reply extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
        comment: {
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
        modelName: 'Reply',
        tableName: 'replies',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      },
    );
  }
  static associate({ Reply, Issue, User }) {
    Reply.belongsTo(Issue, {
      foreignKey: 'issue_num',
      targetKey: 'num',
    });
    Reply.belongsTo(User, {
      foreignKey: 'user_num',
      targetKey: 'num',
    });
  }
};
