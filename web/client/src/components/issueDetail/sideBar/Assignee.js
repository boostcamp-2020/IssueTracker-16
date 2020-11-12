import React from 'react';
import styled from 'styled-components';

const Div = styled.div`
  display: flex;
  align-items: center;
  margin-top: 5px;

  > div {
    &:first-child {
      margin-right: 5px;
    }
    &:last-child {
      font-weight: 700;
    }
  }
`;

const ProfileImage = styled.img`
  width: 20px;
  height: 20px;
  border-radius: 50%;
`;

export default function Assignee({ id, imageUrl }) {
  return (
    <Div>
      <div>
        <ProfileImage src={imageUrl} />
      </div>
      <div>{id}</div>
    </Div>
  );
}
