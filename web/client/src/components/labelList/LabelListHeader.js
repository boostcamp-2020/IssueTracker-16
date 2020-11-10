import React from 'react';

import ListHeader from '../common/ListHeader';

export default function LabelListHeader({ count }) {
  return <ListHeader isIssueList={false}>{count} labels</ListHeader>;
}
