import React from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import CloseIcon from '../../../statics/svg/closeIcon';
import FilterList from './FilterList';

const Modal = styled.div`
  position: absolute;
  top: 30px;
  left: 0px;
  width: max-content;
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

export default function SelectModal({ setIsOpen, setSearchInput }) {
  const handleClickClose = event => {
    event.preventDefault();
    setIsOpen(false);
  };

  return (
    <Modal>
      <ModalHeader>
        <h3>Filter Issues</h3>
        <button onClick={handleClickClose}>
          <CloseIcon />
        </button>
      </ModalHeader>
      <FilterList {...{ setIsOpen, setSearchInput }} />
    </Modal>
  );
}
