import React, { useState, useEffect } from 'react';
import axios from 'axios';

import LabelItem from './LabelItem';

export default function LabelListBody() {
  const [labels, setLabels] = useState([]);
  useEffect(() => {
    const getLabels = () => axios('/api/labels');
    getLabels().then(({ data }) => setLabels(data));
  }, []);
  return (
    <div>
      {labels.length &&
        labels.map(label => <LabelItem key={label.num} {...label} />)}
    </div>
  );
}
