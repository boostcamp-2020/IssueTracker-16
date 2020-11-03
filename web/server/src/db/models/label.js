const { Model, DataTypes } = require('sequelize');
module.exports = class Label extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
        name: {
          type: DataTypes.STRING(100),
          allowNull: false,
          unique: true,
        },
        color: {
          type: DataTypes.CHAR(6),
          allowNull: false,
        },
        description: {
          type: DataTypes.STRING,
        },
      },
      {
        sequelize,
        timestamps: false,
        underscored: true,
        modelName: 'Label',
        tableName: 'labels',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      },
    );
  }
  static associate({ Label, Issue }) {
    Label.belongsToMany(Issue, {
      as: 'labeling',
      through: 'issues_labels',
      foreignKey: 'label_num',
    });
  }
};
