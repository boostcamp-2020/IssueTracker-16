import React from 'react';

import Label from '../common/Label';

export default function IssueItem({
  title,
  author,
  labels,
  assignees,
  milestone,
  isClosed,
  createdAt,
}) {
  return (
    <div>
      <span>{isClosed ? 'X' : 'O'}</span>
      <span>{title} </span>
      <span>
        {labels.map(label => (
          <Label key={label.num} {...label} />
        ))}
      </span>
      <span>
        {assignees.map(a => (
          <div key={a.num}>{a.id}</div>
        ))}
      </span>
      <br />
      <span>{author.id}</span>
      <span>{createdAt}</span>
      <span>{milestone.title}</span>
      <br />
    </div>
  );
}
