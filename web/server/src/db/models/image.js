const { Model, DataTypes } = require('sequelize');
module.exports = class Image extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primaryKey: true,
        },
        uri: {
          type: DataTypes.STRING,
        },
        path: {
          type: DataTypes.STRING,
        },
      },
      {
        sequelize,
        underscored: true,
        timestamps: false,
        modelName: 'Image',
        tableName: 'images',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      }
    );
  }
  static associate() {
    return;
  }
};
