import React, { useState, useEffect } from 'react';
import axios from 'axios';

import LabelListHeader from './LabelListHeader';
import LabelListBody from './LabelListBody';

export default function LabelList() {
  const [labels, setLabels] = useState([]);

  useEffect(() => {
    const getLabels = () => axios('/api/labels');
    getLabels().then(({ data }) => setLabels(data));
  }, []);

  return (
    <div>
      <LabelListHeader count={labels.length} />
      <LabelListBody labels={labels} />
    </div>
  );
}
