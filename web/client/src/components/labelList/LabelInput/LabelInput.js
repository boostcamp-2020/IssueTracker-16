import React, { useState } from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import getRandomColor from '../../../utils/getRandomColor';
import Label from '../../common/Label';
import NameInput from './NameInput';
import DescriptionInput from './DescriptionInput';
import ColorInput from './ColorInput';
import GreenButton from '../../common/GreenButton';
import CancelButton from './CancelButton';

const Wrapper = styled.div`
  margin-bottom: 16px;
  padding: 16px;
  border: 1px solid #e1e4e8;
  border-radius: 6px;
  background-color: #fafbfc;

  > div:first-child {
    margin-bottom: 8px;
  }
`;

const Buttons = styled.div`
  display: flex;

  > button:last-child {
    min-width: 110px;
  }
`;

const Form = styled.form`
  margin-top: 16px;
  display: flex;
  justify-content: space-between;

  > div {
    display: flex;

    &:first-child {
      width: 70%;
      justify-content: flex-start;
    }
    &:last-child {
      width: 20%;
      justify-content: flex-end;
      align-items: flex-end;
    }

    input[type='text'] {
      height: 30px;
      padding: 5px 12px;
      border: 1px solid #e1e4e8;
      border-radius: 6px;
      outline: none;
      font-size: 14px;

      &:focus {
        border: 1px solid #0366d6;
        box-shadow: 0 0 8px #c8e1ff;
      }
    }

    button {
      height: 30px;
    }
  }
`;

export default function LabelInput() {
  const isLabelList = true;
  const [name, setName] = useState('Label preview');
  const [color, setColor] = useState(getRandomColor);
  const [colorInput, setColorInput] = useState(`#${color}`);

  return (
    <Wrapper>
      <Label {...{ name, color, isLabelList }}></Label>
      <Form>
        <div>
          <NameInput {...{ setName }}></NameInput>
          <DescriptionInput></DescriptionInput>
          <ColorInput
            {...{ color, setColor, colorInput, setColorInput }}
          ></ColorInput>
        </div>
        <Buttons>
          <CancelButton />
          <GreenButton>Create label</GreenButton>
        </Buttons>
      </Form>
    </Wrapper>
  );
}
