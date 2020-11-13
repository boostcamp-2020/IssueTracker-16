import React, { useState } from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';
import IssueOpenClosedButton from './IssueOpenClosedButton';
import SubmitButton from './SubmitButton';

const Div = styled.div`
  display: flex;
`;

const ImageWrap = styled.div`
  margin-right: 15px;
`;

const ProfileImage = styled.img`
  width: 40px;
  height: 40px;
  border-radius: 50%;
`;

const Body = styled.div`
  width: 100%;
  border: 1px solid #${COLOR.lightGray};
  border-radius: 10px;
`;

const Top = styled.div`
  background-color: #${COLOR.backGray};
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
  border-bottom: 1px solid #${COLOR.lightGray};
  display: flex;
`;

const Tap = styled.div`
  background-color: white;
  margin: 10px 10px 0 10px;
  padding: 10px 15px 10px 15px;
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
  border: 1px solid #${COLOR.lightGray};
  border-bottom: none;
  position: relative;
  bottom: -1px;
`;

const Middle = styled.div`
  padding: 15px 10px 5px 10px;
`;

const TextArea = styled.textarea`
  width: 100%;
  border: 1px solid #${COLOR.lightGray};
  border-radius: 5px;
  outline: none;
  padding: 10px 5px;
  min-height: 100px;
  resize: vertical;
`;

const Bottom = styled.div`
  display: flex;
  justify-content: flex-end;
  padding: 0 10px 10px 10px;

  > * {
    margin-left: 5px;
  }
`;

export default function CommentInput({ num, isClosed }) {
  const writer = {
    imageUrl: 'https://avatars3.githubusercontent.com/u/43347250?s=40&v=4',
    num: 1,
    id: 'test-seokju2ng',
  };
  const [content, setContent] = useState('');
  const changeContent = ({ target }) => setContent(target.value);
  return (
    <Div>
      <ImageWrap>
        <ProfileImage src={writer.imageUrl} />
      </ImageWrap>
      <Body>
        <Top>
          <Tap>Write</Tap>
        </Top>
        <Middle>
          <TextArea
            placeholder="Leave a comment"
            defaultValue={content}
            onChange={changeContent}
          ></TextArea>
        </Middle>
        <Bottom>
          <IssueOpenClosedButton {...{ num, isClosed }} />
          <SubmitButton {...{ num, content }} />
        </Bottom>
      </Body>
    </Div>
  );
}
