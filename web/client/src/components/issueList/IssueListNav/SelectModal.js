import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

import COLOR from '../../../utils/color';

const Modal = styled.div`
  position: absolute;
  margin: 8px 0 16px;
  display: flex;
  flex-direction: column;
  background-color: #${COLOR.white};
  border: 1px solid #${COLOR.lightGray};
  border-radius: 6px;
`;

const ModalHeader = styled.div`
  display: flex;
  justify-content: space-between;
  padding: 7px 7px 7px 16px;
  font-size: 12px;

  button {
    background-color: transparent;
    border: none;
    outline: none;
    cursor: pointer;

    svg {
      fill: #${COLOR.darkGray};
    }
  }
`;
const SelectList = styled.div`
  display: flex;
  flex-direction: column;

  a {
    padding: 7px 16px;
    border-top: 1px solid #${COLOR.lightGray};
    color: #${COLOR.black};
    text-decoration: none;
    font-size: 12px;
  }
`;
export default function SelectModal({ setIsOpen }) {
  return (
    <Modal>
      <ModalHeader>
        <h3>Filter Issues</h3>
      </ModalHeader>
      <SelectList>
        <Link to={'/issues?is=open'}>Open issues</Link>
        <Link to={'/issues?is=open+author=@me'}>Your issues</Link>
        <Link to={'/issues?is=open+assignee=@me'}>
          Everything assigned to you
        </Link>
        <Link to={'/issues?is=open+commenter=@me'}>
          Everything commented by you
        </Link>
        <Link to={'/issues?is=close'}>Closed Issues</Link>
      </SelectList>
    </Modal>
  );
}
