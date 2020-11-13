import React from 'react';

import GreenButton from '../common/GreenButton';
import LabelMilestoneNavigator from '../common/LabelMilestoneNavigator';
import ListNav from '../common/ListNav';

export default function LabelListNav({ isHidden, setState }) {
  const toggleInput = event => {
    event.preventDefault();
    setState({ isHidden: !isHidden });
  };
  return (
    <ListNav>
      <div>
        <LabelMilestoneNavigator page={'label'} />
      </div>
      <div>
        <GreenButton onClick={toggleInput}>New Label</GreenButton>
      </div>
    </ListNav>
  );
}
