import React, { useState, useEffect } from 'react';
import axios from 'axios';

import LabelPopEl from './LabelPopEl';

export default function LabelsPop({ labels: labelings }) {
  const [labels, setLabels] = useState([]);
  useEffect(() => {
    const setModel = ({ data }) =>
      setLabels(
        data.map(label => {
          if (labelings?.filter(v => v.num === label.num).length) {
            label.isChecked = true;
            return label;
          }
          return label;
        }),
      );
    axios
      .get('/api/labels')
      .then(setModel)
      .catch(({ response }) => alert(response.data.message));
  }, [labelings]);

  return (
    <div>
      {labels.length &&
        labels.map(label => <LabelPopEl key={label.num} {...label} />)}
    </div>
  );
}
