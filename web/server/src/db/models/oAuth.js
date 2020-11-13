const { Model, DataTypes } = require('sequelize');
module.exports = class OAuth extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
        name: {
          type: DataTypes.STRING,
          unique: true,
          allowNull: false,
        },
      },
      {
        sequelize,
        underscored: true,
        timestamps: false,
        modelName: 'OAuth',
        tableName: 'oauths',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      },
    );
  }
  static associate() {}
};
