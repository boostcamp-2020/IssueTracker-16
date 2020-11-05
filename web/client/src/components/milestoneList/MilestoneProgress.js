import React from 'react';
import styled from 'styled-components';

const ProgressBar = styled.div`
  height: 10px;
  width: 90%;
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
  font-size: 10pt;
  font-weight: 500;
  color: #a0a0a0;

  > span {
    margin-right: 10px;

    > span {
      color: #404040;
    }
  }
`;

export default function MilestoneProgress({ openedIssues, closedIssues }) {
  const percentage =
    openedIssues + closedIssues
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
