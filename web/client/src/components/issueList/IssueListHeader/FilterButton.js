import React, { useRef, useState, useEffect } from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import SelectModal from './SelectModal';

const Wrapper = styled.div`
  position: relative;
  min-width: 90px;

  > button {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    outline: none;
    font-size: 14px;
    border: none;
    background-color: #${COLOR.backGray};
    color: #${COLOR.darkGray};

    &:hover {
      color: #${COLOR.black};
    }
  }
`;

export default function FilterButton({ type }) {
  const [isOpen, setIsOpen] = useState(false);
  const ref = useRef(null);

  const handleClickOutside = event => {
    if (ref.current && !ref.current.contains(event.target)) {
      setIsOpen(false);
    }
  };
  const handleClick = event => {
    event.preventDefault();
    setIsOpen(!isOpen);
  };

  useEffect(() => {
    document.addEventListener('click', handleClickOutside, true);
    return () => {
      document.removeEventListener('click', handleClickOutside, true);
    };
  }, []);

  return (
    <Wrapper ref={ref}>
      <button onClick={handleClick}>{type} ▾</button>
      {isOpen && <SelectModal {...{ setIsOpen, type }} />}
    </Wrapper>
  );
}
