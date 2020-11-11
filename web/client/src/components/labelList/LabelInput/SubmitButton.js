import React from 'react';
import axios from 'axios';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import isValidColor from '../../../utils/isValidColor';

const Button = styled.button`
  height: 32px;
  padding: 5px 16px;
  background-color: #${COLOR.green};
  color: white;
  border: 1px solid #268841;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 6px;
  outline: none;

  &:hover {
    background-color: #2a9847;
  }

  &:disabled {
    background-color: #94d3a2;
  }
`;

export default function SubmitButton({ name, description, color, colorInput }) {
  const createLabel = body => axios.post(`/api/labels`, body);
  const handleClick = event => {
    event.preventDefault();
    createLabel({ name, description, color })
      .then(({ data }) => {
        if (data.success) window.location = '/labels';
      })
      .catch(({ response }) => alert(response.data.message));
  };
  return (
    <Button disabled={!name || !isValidColor(colorInput)} onClick={handleClick}>
      Create label
    </Button>
  );
}
