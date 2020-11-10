import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const ProgressBar = styled.div`
  height: 10px;
  border-radius: 15px;
  background-color: #e1e4e8;
`;
const Progress = styled.div`
  height: 10px;
  width: ${props => props.percentage}%;
  border-radius: ${props =>
    props.percentage === 100 ? '15px' : '15px 0px 0px 15px'};
  background-color: #28a745;
`;
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

export default function MilestoneProgress({ openedIssues, closedIssues }) {
  const percentage = closedIssues
    ? Math.floor((openedIssues / (openedIssues + closedIssues)) * 100)
    : 0;

  return (
    <div>
      <ProgressBar>
        <Progress percentage={percentage}></Progress>
      </ProgressBar>
      <ProgressDesc>
        <span>
          <span>{`${percentage}% `}</span>complete
        </span>
        <span>
          <span>{`${openedIssues} `}</span>open
        </span>
        <span>
          <span>{`${closedIssues} `}</span>closed
        </span>
      </ProgressDesc>
    </div>
  );
}
