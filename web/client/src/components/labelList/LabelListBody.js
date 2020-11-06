import React, { useState, useEffect } from 'react';
import axios from 'axios';

import LabelItem from './LabelItem';
import ListBody from '../common/ListBody';

export default function LabelListBody() {
  const [labels, setLabels] = useState([]);
  useEffect(() => {
    const getLabels = () => axios('/api/labels');
    getLabels().then(({ data }) => setLabels(data));
  }, []);
  return (
    <ListBody>
      {labels.length &&
        labels.map(label => <LabelItem key={label.num} {...label} />)}
    </ListBody>
  );
}
