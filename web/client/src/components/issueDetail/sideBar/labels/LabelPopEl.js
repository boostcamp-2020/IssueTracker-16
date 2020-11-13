import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../../utils/color';
import CheckIcon from '../../../../statics/svg/checkIcon';

const Div = styled.div`
  padding: 5px 0;
  border-bottom: 1px solid #${COLOR.lightGray};
  background-color: white;
  cursor: pointer;
  > div {
    color: #${COLOR.darkGray};
  }
  &:hover {
    background-color: #${COLOR.blue};
    > div {
      color: white;
    }
    svg {
      fill: white;
    }
  }
`;

const Label = styled.div`
  display: flex;
  align-items: center;
`;

const Check = styled.div`
  margin-left: 5px;
  width: 20px;
`;

const Color = styled.div`
  margin-right: 5px;
  background-color: #${props => props.color};
  width: 14px;
  height: 14px;
  border-radius: 50%;
`;

const Name = styled.div`
  margin-left: 5px;
  font-size: 14px;
  ${props => props.isChecked && `font-weight: 700;`}
`;

const Description = styled.div`
  margin-left: 24px;
  font-size: 13px;
  margin-top: 3px;
`;

export default function LabelPopEl({
  num,
  name,
  color,
  description,
  isChecked,
}) {
  return (
    <Div>
      <Label>
        <Check>{isChecked && <CheckIcon />}</Check>
        <Color color={color} />
        <Name isChecked={isChecked}>{name}</Name>
      </Label>
      <Description>{description}</Description>
    </Div>
  );
}
