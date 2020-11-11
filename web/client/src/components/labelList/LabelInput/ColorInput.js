import React from 'react';
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
  }
`;

export default function ColorInput({
  color,
  setColor,
  colorInput,
  setColorInput,
}) {
  const handleChange = event => {
    const { name, value } = event.target;
    if (name === 'color') {
      setColorInput(value.length ? value : '#');
      if (isValidColor(value)) setColor(value.substring(1));
    }
  };

  const handleClick = event => {
    event.preventDefault();
    setColor(getRandomColor);
    setColorInput(`#${color}`);
  };
  return (
    <Color>
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
