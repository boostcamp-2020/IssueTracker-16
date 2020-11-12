import React from 'react';
import axios from 'axios';
import styled from 'styled-components';

import ListItem from '../common/ListItem';
import Label from '../common/Label';

const Description = styled.div`
  width: 55%;
  margin: auto 0;
`;

const LabelView = styled.div`
  width: 25%;
  margin: auto 0;
`;

const Buttons = styled.div`
  text-align: right;
  width: 20%;
  margin: auto 0;
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
  const deleteLabel = num => axios.delete(`/api/labels/${num}`);
  const handleDeleteClick = event => {
    event.preventDefault();
    if (
      window.confirm(
        'Are you sure? Deleting a label will remove it from all issues and pull requests.',
      )
    ) {
      deleteLabel(num)
        .then(({ data }) => {
          if (data.success) window.location = '/labels';
        })
        .catch(({ response }) => alert(response.data.message));
    }
  };
  return (
    <ListItem>
      <LabelView>
        <Label {...{ name, color, isLabelList }} />
      </LabelView>
      <Description>{description}</Description>
      <Buttons>
        <Button>Edit</Button>
        <Button onClick={handleDeleteClick}>Delete</Button>
      </Buttons>
    </ListItem>
  );
}
