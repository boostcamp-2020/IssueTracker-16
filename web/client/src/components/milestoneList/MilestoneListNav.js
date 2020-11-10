import React from 'react';

import GreenButton from '../common/GreenButton';
import LabelMilestoneNavigator from '../common/LabelMilestoneNavigator';
import ListNav from '../common/ListNav';

export default function MilestoneListNav() {
  return (
    <ListNav>
      <div>
        <LabelMilestoneNavigator page={'milestone'} />
      </div>
      <div>
        <GreenButton>New Milestone</GreenButton>
      </div>
    </ListNav>
  );
}
