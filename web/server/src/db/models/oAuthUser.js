const { Model, DataTypes } = require('sequelize');
module.exports = class OAuthUser extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
        id: {
          type: DataTypes.STRING,
          allowNull: false,
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
  static associate({ OAuthUser, User, OAuth }) {
    OAuthUser.belongsTo(User, {
      foreignKey: 'user_num',
      targetKey: 'num',
      onDelete: 'cascade',
    });
    OAuthUser.belongsTo(OAuth, {
      foreignKey: 'oauth_num',
      targetKey: 'num',
      onDelete: 'cascade',
    });
  }
};
