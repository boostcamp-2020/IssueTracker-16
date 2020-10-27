const { Model, DataTypes } = require('sequelize');

module.exports = class Issue extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primaryKey: true,
        },
        title: {
          type: DataTypes.STRING(100),
          allowNull: false,
        },
        milestoneNum: {
          type: DataTypes.INTEGER,
          allowNull: false,
        },
        userNum: {
          type: DataTypes.INTEGER,
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
      }
    );
  }
  static associate() {}
};
