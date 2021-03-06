const { Model, DataTypes } = require('sequelize');
module.exports = class Milestone extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
        title: {
          type: DataTypes.STRING(100),
          allowNull: false,
          unique: true,
        },
        dueDate: {
          type: DataTypes.DATEONLY,
        },
        description: {
          type: DataTypes.STRING,
        },
        isClosed: {
          type: DataTypes.BOOLEAN,
          allowNull: false,
          defaultValue: false,
        },
      },
      {
        sequelize,
        timestamps: false,
        underscored: true,
        modelName: 'Milestone',
        tableName: 'milestones',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      },
    );
  }
  static associate({ Milestone, Issue }) {
    Milestone.hasMany(Issue, {
      foreignKey: 'milestoneNum',
      sourceKey: 'num',
    });
  }
};
