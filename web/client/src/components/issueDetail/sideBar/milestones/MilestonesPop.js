import React, { useState, useEffect } from 'react';
import axios from 'axios';

import MilestonePopEl from './MilestonePopEl';

export default function MilestonesPop({ milestone }) {
  const [milestones, setMilestones] = useState([]);
  useEffect(() => {
    const setModel = ({ data }) =>
      setMilestones(
        data.milestones
          .filter(ms => !ms.isClosed)
          .map(ms => {
            if (ms.num === milestone.num) {
              ms.isChecked = true;
              return ms;
            }
            return ms;
          }),
      );
    axios
      .get('/api/milestones')
      .then(setModel)
      .catch(({ response }) => alert(response.data.message));
  }, [milestone]);

  return (
    <div>
      {milestones.length &&
        milestones.map(ms => <MilestonePopEl key={ms.num} {...ms} />)}
    </div>
  );
}
