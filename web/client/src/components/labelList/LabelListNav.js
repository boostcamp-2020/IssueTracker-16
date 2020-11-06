import React from 'react';

import GreenButton from '../common/GreenButton';
import LabelMilestoneNavigator from '../common/LabelMilestoneNavigator';
import ListNav from '../common/ListNav';

export default function LabelListNav() {
  return (
    <ListNav>
      <div>
        <LabelMilestoneNavigator />
      </div>
      <div>
        <GreenButton>New Label</GreenButton>
      </div>
    </ListNav>
  );
}
