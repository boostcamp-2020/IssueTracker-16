import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';

const Div = styled.div`
  border: 1px solid #${COLOR.lightGray};
  position: absolute;
  width: 300px;
  right: 0;
  z-index: 100;
  display: ${props => (props.isHidden ? 'none' : 'block')};
`;

const Title = styled.div`
  background-color: #${COLOR.backGray};
  border-bottom: 1px solid #${COLOR.lightGray};
  font-weight: 700;
  padding: 7px;
  font-size: 15px;
`;

export default function Popup({ children, popTitle, state }) {
  return (
    <Div {...state}>
      <Title>{popTitle}</Title>
      {children}
    </Div>
  );
}
