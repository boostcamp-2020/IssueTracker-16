const { Model, DataTypes } = require('sequelize');
module.exports = class User extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
        id: {
          type: DataTypes.STRING,
          unique: true,
          allowNull: false,
        },
        password: {
          type: DataTypes.CHAR(64),
          allowNull: false,
        },
        name: {
          type: DataTypes.STRING,
          allowNull: false,
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
      },
    );
  }
  static associate({ User, OAuthUser, Issue, Reply, Assignee }) {
    [OAuthUser, Issue, Reply, Assignee].forEach(model =>
      User.hasMany(model, {
        foreignKey: 'user_num',
        sourceKey: 'num',
      }),
    );
  }
};
