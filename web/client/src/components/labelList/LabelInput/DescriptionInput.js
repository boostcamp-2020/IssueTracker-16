import React from 'react';
import styled from 'styled-components';

const Description = styled.div`
  width: 45%;

  > div:first-child {
    margin-bottom: 6px;
    font-size: 14px;
  }

  input[type='text'] {
    width: 95%;
  }
`;

export default function DescriptionInput({ setDescription }) {
  const handleChange = event => {
    const { value } = event.target;

    setDescription(value);
  };
  return (
    <Description>
      <div>Description</div>
      <input
        type="text"
        name="description"
        placeholder="Description (optional)"
        onChange={handleChange}
      ></input>
    </Description>
  );
}
