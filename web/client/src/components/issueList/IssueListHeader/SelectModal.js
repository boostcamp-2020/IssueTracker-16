import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import CloseIcon from '../../../statics/svg/closeIcon';
import UserList from './UserList';
import LabelList from './LabelList';
import MilestoneList from './MilestoneList';

const Modal = styled.div`
  z-index: 100;
  position: absolute;
  top: 23px;
  right: 0px;
  width: 250px;
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

export default function SelectModal({ setIsOpen, type }) {
  const handleClickClose = event => {
    event.preventDefault();
    setIsOpen(false);
  };

  return (
    <Modal>
      <ModalHeader>
        <h3>Filter by {type}</h3>
        <button onClick={handleClickClose}>
          <CloseIcon />
        </button>
      </ModalHeader>
      {(type === 'Author' || type === 'Assignee') && (
        <UserList {...{ setIsOpen, type }} />
      )}
      {type === 'Label' && <LabelList {...{ setIsOpen }} />}
      {type === 'Milestone' && <MilestoneList {...{ setIsOpen }} />}
    </Modal>
  );
}
