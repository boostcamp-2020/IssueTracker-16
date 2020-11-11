import React, { useState } from 'react';
import styled from 'styled-components';

import isValidColor from '../../../utils/isValidColor';
import getRandomColor from '../../../utils/getRandomColor';
import RefreshButton from './RefreshButton';

const Color = styled.div`
  width: 25%;

  > div:first-child {
    margin-bottom: 6px;
    font-size: 14px;
  }

  > div:last-child {
    display: flex;
  }

  input[type='text'] {
    width: 80%;
    color: #${({ isValid }) => (isValid ? '000000' : 'cb2431')};
  }
`;

export default function ColorInput({
  color,
  setColor,
  colorInput,
  setColorInput,
}) {
  const [state, setState] = useState({ isValid: 'true' });
  const handleChange = event => {
    const { value } = event.target;

    setColorInput(value.length ? value : '#');
    if (isValidColor(value)) setColor(value.substring(1));
    setState({ isValid: isValidColor(value) });
  };

  const handleClick = event => {
    event.preventDefault();
    setColor(getRandomColor);
    setColorInput(`#${color}`);
  };
  return (
    <Color {...state}>
      <div>Color</div>
      <div>
        <RefreshButton {...{ color }} onClick={handleClick} />
        <input
          type="text"
          name="color"
          onChange={handleChange}
          value={colorInput}
        ></input>
      </div>
    </Color>
  );
}
