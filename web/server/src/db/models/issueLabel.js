const { Model, DataTypes } = require('sequelize');
module.exports = class IssueLabel extends Model {
  static init(sequelize) {
    return super.init(
      {
        num: {
          type: DataTypes.INTEGER.UNSIGNED,
          autoIncrement: true,
          primaryKey: true,
        },
      },
      {
        sequelize,
        timestamps: false,
        underscored: true,
        modelName: 'IssueLabel',
        tableName: 'issues_labels',
        charset: 'utf8',
        collate: 'utf8_general_ci',
      }
    );
  }
  static associate({ IssueLabel, Issue, Label }) {
    IssueLabel.belongsTo(Issue, {
      foreignKey: 'issue_num',
      targetKey: 'num',
    });
    IssueLabel.belongsTo(Label, {
      foreignKey: 'label_num',
      targetKey: 'num',
      onDelete: 'cascade',
    });
  }
};
