const { Model, DataTypes } = require('sequelize');

module.exports = class Reply extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primaryKey: true,
        },
        comment: {
          type: DataTypes.TEXT,
          allowNull: false,
        },
        issueNum: {
          type: DataTypes.INTEGER,
          allowNull: false,
        },
        userNum: {
          type: DataTypes.INTEGER,
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
      }
    );
  }
  static associate() {}
};
