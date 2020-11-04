import React from 'react';

import Label from '../labelList/Label';

export default function IssueItem({
  issue: { title, author, labels, assignees, milestone, isClosed, createdAt },
}) {
  return (
    <div>
      <span>{isClosed ? 'X' : 'O'}</span>
      <span>{title} </span>
      <span>
        {labels.map(label => (
          <Label key={label.num} label={label} />
        ))}
      </span>
      <span>
        {assignees.map(a => (
          <div>{a.id}</div>
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
