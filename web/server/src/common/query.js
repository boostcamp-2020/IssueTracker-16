module.exports = {
  countOpenedIssues: `(
    SELECT COUNT(*)
    FROM issues
    WHERE issues.milestone_num = Milestone.num
      AND NOT issues.is_closed
  )`,
  countClosedIssues: `(
    SELECT COUNT(*)
    FROM issues
    WHERE issues.milestone_num = Milestone.num
      AND issues.is_closed
  )`,
};
