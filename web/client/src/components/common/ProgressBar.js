import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';

const Div = styled.div`
  height: 10px;
  border-radius: 15px;
  background-color: #${COLOR.lightGray};
`;
const Progress = styled.div`
  height: 10px;
  width: ${props => props.percentage}%;
  border-radius: ${props =>
    props.percentage === 100 ? '15px' : '15px 0px 0px 15px'};
  background-color: #${props => props.color};
`;

export default function ProgressBar({ color, open, closed }) {
  const percentage = closed ? Math.floor((closed / (open + closed)) * 100) : 0;

  return (
    <Div>
      <Progress {...{ percentage, color }} />
    </Div>
  );
}
