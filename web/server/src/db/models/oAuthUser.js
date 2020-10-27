const { Model, DataTypes } = require('sequelize');
module.exports = class OAuthUser extends Model {
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
      },
      {
        sequelize,
        underscored: true,
        timestamps: false,
        modelName: 'OAuthUser',
        tableName: 'oauths_users',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      }
    );
  }
  static associate() {
    return;
  }
};
