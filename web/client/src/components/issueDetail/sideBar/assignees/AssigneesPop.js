import React, { useState, useEffect } from 'react';
import axios from 'axios';

import Assignee from './AssigneePopEl';

export default function Assignees({ assignees }) {
  const [users, setUsers] = useState([]);
  useEffect(() => {
    axios
      .get('/api/users')
      .then(({ data }) =>
        setUsers(
          data.map(user => {
            if (assignees?.filter(v => v.num === user.num).length) {
              user.isChecked = true;
              return user;
            }
            return user;
          }),
        ),
      )
      .catch(({ response }) => alert(response.data.message));
  }, [assignees]);

  return (
    <div>
      {users.length && users.map(user => <Assignee key={user.num} {...user} />)}
    </div>
  );
}
