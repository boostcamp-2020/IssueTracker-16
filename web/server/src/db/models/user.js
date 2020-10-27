const { Model, DataTypes } = require('sequelize');
module.exports = class User extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primaryKey: true,
        },
        id: {
          type: DataTypes.STRING,
        },
        password: {
          type: DataTypes.CHAR(64),
        },
        name: {
          type: DataTypes.STRING,
        },
      },
      {
        sequelize,
        underscored: true,
        timestamps: false,
        modelName: 'User',
        tableName: 'users',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      }
    );
  }
  static associate() {
    return;
  }
};
