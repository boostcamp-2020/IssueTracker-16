import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import ProgressBar from '../../common/ProgressBar';

const Title = styled.div`
  margin-top: 5px;
  font-size: 13px;
  color: #${COLOR.darkGray};
  font-weight: 700;
`;

export default function Milestone({
  openedIssues: open,
  closedIssues: closed,
  title,
}) {
  return (
    <div>
      <ProgressBar {...{ open, closed, color: COLOR.green }} />
      <Title>{title}</Title>
    </div>
  );
}
