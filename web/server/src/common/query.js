module.exports = {
  findAllMilestones: `
    select num,
       title,
       due_date as dueDate,
       description,
       (select count(*)
        from issues
        where issues.milestone_num = milestones.num
          and not issues.is_deleted
          and not issues.is_closed) as openedIssues,
       (select count(*)
        from issues
        where issues.milestone_num = milestones.num
          and not issues.is_deleted
          and issues.is_closed)     as closedIssues
    from milestones`,
};
