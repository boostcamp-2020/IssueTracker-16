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

export default function DescriptionInput() {
  return (
    <Description>
      <div>Description</div>
      <input
        type="text"
        name="description"
        placeholder="Description (optional)"
      ></input>
    </Description>
  );
}
