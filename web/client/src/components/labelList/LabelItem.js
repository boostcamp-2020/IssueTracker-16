import React from 'react';
import styled from 'styled-components';

import ListItem from '../common/ListItem';
import Label from '../common/Label';

const Description = styled.div`
  width: 55%;
`;

const LabelView = styled.div`
  width: 25%;
`;

const Buttons = styled.div`
  text-align: right;
  width: 20%;
`;

const Button = styled.button`
  border: none;
  background-color: transparent;
  color: gray;
  margin-left: 10px;
  outline: none;
  cursor: pointer;
`;

export default function LabelItem({ num, name, color, description }) {
  const isLabelList = true;
  return (
    <ListItem>
      <LabelView>
        <Label {...{ name, color, isLabelList }} />
      </LabelView>
      <Description>{description}</Description>
      <Buttons>
        <Button>Edit</Button>
        <Button>Delete</Button>
      </Buttons>
    </ListItem>
  );
}
