import React from 'react';

import LabelItem from './LabelItem';
import ListBody from '../common/ListBody';
import NoResult from '../common/NoResult';
import LabelLogo from '../../statics/svg/label';

export default function LabelListBody({ labels }) {
  return (
    <ListBody>
      {labels.length ? (
        labels.map(label => <LabelItem key={label.num} {...label} />)
      ) : (
        <NoResult>
          <LabelLogo />
          <h3>We couldn’t find anything!</h3>
        </NoResult>
      )}
    </ListBody>
  );
}
