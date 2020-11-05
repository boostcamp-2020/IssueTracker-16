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

export default function LabelItem({ num, name, color, description }) {
  return (
    <ListItem>
      <LabelView>
        <Label {...{ name, color }} />
      </LabelView>
      <Description>{description}</Description>
      <Buttons>
        <button>Edit</button>
        <button>Delete</button>
      </Buttons>
    </ListItem>
  );
}
