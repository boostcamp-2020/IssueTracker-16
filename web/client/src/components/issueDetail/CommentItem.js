import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';
import getDiffTime from '../../utils/getDiffTime';
import GreenButton from '../common/GreenButton';

const CommentItemElement = styled.div`
  display: flex;
  margin-bottom: 15px;
`;

const Left = styled.div`
  margin-right: 15px;
  display: flex;
`;

const ProfileImage = styled.img`
  width: 40px;
  height: 40px;
  border-radius: 50%;
`;

const Comment = styled.div`
  width: 100%;
  border: 1px solid #${COLOR.lightGray};
  border-radius: 10px;

  > div {
    padding: 15px;
  }
`;
const Top = styled.div`
  display: flex;
  background-color: #${({ isMine }) => (isMine ? COLOR.lightBlue : COLOR.backGray)};
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
  border-bottom: 1px solid #${COLOR.lightGray};
`;
const Writer = styled.div`
  font-weight: 700;
`;
const Time = styled.div`
  margin-left: 5px;
  color: #${COLOR.darkGray};
`;
const Content = styled.div``;
const Right = styled.div`
  margin-left: auto;
  display: flex;
  * {
    margin-left: 5px;
  }

  > button {
    height: auto;
    padding: 1px 7px;
    font-size: 14px;
    font-weight: inherit;
    color: #${COLOR.darkGray};
  }
`;

const Author = styled.div`
  color: #${COLOR.darkGray};
  border: 1px solid #${COLOR.lightGray};
  padding: 0 5px;
  border-radius: 15px;
`;

export default function CommentItem({
  num,
  writer,
  content,
  createdAt,
  isAuthor,
  isMine,
}) {
  return (
    <CommentItemElement>
      <Left>
        <ProfileImage src={writer.imageUrl} />
      </Left>
      <Comment>
        <Top {...{ isMine }}>
          <Left>
            <Writer>{writer.id}</Writer>
            <Time>commented {getDiffTime(createdAt)}</Time>
          </Left>
          <Right>
            {isAuthor && <Author>Author</Author>}
            {isMine && <GreenButton isNotGreen={true}>Edit</GreenButton>}
          </Right>
        </Top>
        <Content>{content}</Content>
      </Comment>
    </CommentItemElement>
  );
}
