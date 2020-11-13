import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import ProgressBar from '../../common/ProgressBar';

const ProgressDesc = styled.div`
  margin-top: 5px;
  font-size: 14px;
  color: #${COLOR.darkGray};

  > span {
    margin-right: 10px;

    > span {
      color: #${COLOR.black};
      font-weight: 600;
    }
  }
`;

export default function MilestoneProgress({
  openedIssues: open,
  closedIssues: closed,
}) {
  const percentage = closed ? Math.floor((open / (open + closed)) * 100) : 0;
  return (
    <div>
      <ProgressBar {...{ open, closed, color: COLOR.green }} />
      <ProgressDesc>
        <span>
          <span>{`${percentage}% `}</span>complete
        </span>
        <span>
          <span>{`${open} `}</span>open
        </span>
        <span>
          <span>{`${closed} `}</span>closed
        </span>
      </ProgressDesc>
    </div>
  );
}
