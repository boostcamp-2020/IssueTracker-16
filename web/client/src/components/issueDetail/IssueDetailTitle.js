import React, { useState } from 'react';
import styled from 'styled-components';
import axios from 'axios';

import COLOR from '../../utils/color';
import GreenButton from '../common/GreenButton';

const Div = styled.div`
  margin-top: 5px;
  display: flex;
  align-items: center;
  justify-content: ${props => props.justifyContent};

  > * {
    margin-right: 5px;
  }
`;

const Title = styled.div`
  font-size: 23pt;
`;

const IssueNum = styled.div`
  font-size: 23pt;
  color: #${COLOR.darkGray};
`;

const Input = styled.input`
  width: 100%;
  border: 1px solid #${COLOR.lightGray};
  background-color: #${COLOR.backGray};
  border-radius: 5px;
  outline: none;
  padding: 7px 13px;
  &:focus {
    box-shadow: 0 0 0 3px #${COLOR.shadowBlue};
    border: 1px solid #${COLOR.blue};
    background-color: white;
  }
`;

export default function IssueDetailTitle({ num, title }) {
  const [state, setState] = useState({ isEdit: false });
  const [inputTitle, setInputTitle] = useState(title);
  const [viewTitle, setViewTitle] = useState(title);

  const toggleState = () => setState({ isEdit: !state.isEdit });
  const changeTitle = event => setInputTitle(event.target.value);

  const clickSaveBtn = event => {
    axios
      .patch(`/api/issues/${num}`, { title: inputTitle })
      .then(({ data }) => {
        if (data.success) {
          setViewTitle(inputTitle);
          toggleState();
        }
      })
      .catch(({ response }) => alert(response.data.message));
  };
  return (
    <Div justifyContent="space-between">
      {state.isEdit ? (
        <>
          <Input
            defaultValue={viewTitle}
            autoFocus={true}
            onChange={changeTitle}
          />
          <GreenButton onClick={clickSaveBtn}>Save</GreenButton>
          <GreenButton isNotGreen={true} onClick={toggleState}>
            Cancel
          </GreenButton>
        </>
      ) : (
        <>
          <Div>
            <Title>{viewTitle}</Title>
            <IssueNum>#{num}</IssueNum>
          </Div>
          <GreenButton isNotGreen={true} onClick={toggleState}>
            Edit
          </GreenButton>
        </>
      )}
    </Div>
  );
}
