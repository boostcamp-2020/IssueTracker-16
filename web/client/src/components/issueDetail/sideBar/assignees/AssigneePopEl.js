import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../../utils/color';
import CheckIcon from '../../../../statics/svg/checkIcon';

const Div = styled.div`
  display: flex;
  align-items: center;
  padding: 5px 0;
  border-bottom: 1px solid #${COLOR.lightGray};
  background-color: white;
  cursor: pointer;
  > div {
    color: #${COLOR.darkGray};
  }
  &:hover {
    background-color: #${COLOR.blue};
    > div {
      color: white;
    }
    svg {
      fill: white;
    }
  }
`;

const Check = styled.div`
  margin-left: 5px;
  width: 20px;
`;

const Image = styled.div`
  margin-right: 5px;
`;

const ProfileImage = styled.img`
  width: 20px;
  height: 20px;
  border-radius: 50%;
`;

const ID = styled.div`
  font-size: 15px;
  font-weight: 700;
`;

const Name = styled.div`
  margin-left: 5px;
  font-size: 13px;
`;

export default function Assignee({ num, id, name, imageUrl, isChecked }) {
  return (
    <Div>
      <Check>{isChecked && <CheckIcon />}</Check>
      <Image>
        <ProfileImage src={imageUrl} />
      </Image>
      <ID>{id}</ID>
      <Name>{name}</Name>
    </Div>
  );
}
