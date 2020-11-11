const { Model, DataTypes } = require('sequelize');
module.exports = class Authorization extends Model {
  static init(sequelize) {
    return super.init(
      {
        accessToken: {
          type: DataTypes.STRING,
          allowNull: false,
        },
      },
      {
        sequelize,
        underscored: true,
        timestamps: false,
        modelName: 'Authorization',
        tableName: 'authorizations',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      },
    );
  }
  static associate({ Authorization, User, OAuth }) {
    User.belongsToMany(OAuth, {
      through: Authorization,
      foreignKey: 'userNum',
    });
    OAuth.belongsToMany(User, {
      through: Authorization,
      foreignKey: 'oAuthNum',
    });
  }
};
