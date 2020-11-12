import React from 'react';

import MilestoneItem from './MilestoneItem/MilestoneItem';
import ListBody from '../common/ListBody';
import NoResult from '../common/NoResult';
import MilestoneLogo from '../../statics/svg/milestone';

export default function MilestoneListBody({ milestones }) {
  return (
    <ListBody>
      {!milestones.length && (
        <NoResult>
          <MilestoneLogo />
          <h3>We couldn’t find anything!</h3>
        </NoResult>
      )}
      {!!milestones.length &&
        milestones.map(milestone => (
          <MilestoneItem key={milestone.num} {...milestone} />
        ))}
    </ListBody>
  );
}
