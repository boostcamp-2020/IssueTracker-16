const { Model, DataTypes } = require('sequelize');
module.exports = class Asignee extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primaryKey: true,
        },
      },
      {
        sequelize,
        timestamps: false,
        underscored: true,
        modelName: 'Asignee',
        tableName: 'asignees',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      }
    );
  }
  static associate() {}
};
