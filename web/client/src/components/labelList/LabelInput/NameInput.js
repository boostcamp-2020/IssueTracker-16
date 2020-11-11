import React from 'react';
import styled from 'styled-components';

const Name = styled.div`
  width: 30%;

  > div:first-child {
    margin-bottom: 6px;
    font-size: 14px;
  }

  input[type='text'] {
    width: 95%;
  }
`;

export default function NameInput({ setName }) {
  const handleChange = event => {
    const { value } = event.target;

    setName(value);
  };
  return (
    <Name>
      <div>Label name</div>
      <input
        type="text"
        name="name"
        placeholder="Label name"
        onChange={handleChange}
      ></input>
    </Name>
  );
}
