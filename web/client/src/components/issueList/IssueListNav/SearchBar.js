import React, { useState } from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import SearchIcon from '../../../statics/svg/searchIcon';
import SelectModal from './SelectModal';

const Wrapper = styled.div`
  width: 68%;
  display: flex;
  align-items: center;
  background-color: #${COLOR.backGray};

  input[type='text'] {
    height: 30px;
    width: 90%;
    padding: 5px 12px 5px 0;
    border: 1px solid #e1e4e8;
    border-left: none;
    border-radius: 0 6px 6px 0;
    outline: none;
    font-size: 14px;
    background-color: #${COLOR.backGray};
    color: #${COLOR.darkGray};
  }
`;
const Search = styled.div`
  width:32px;
  height:30px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-top: 1px solid #e1e4e8;
  border-bottom: 1px solid #e1e4e8;
  

  svg {
    fill: #${COLOR.darkGray}};
  }
`;

const FilterTab = styled.div`
  position: relative;
  min-width: 90px;

  > button {
    height: 30px;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    outline: none;
    font-size: 14px;
    border: 1px solid #e1e4e8;
    border-radius: 6px 0 0 6px;
    background-color: #${COLOR.backGray};
    color: #${COLOR.darkGray};

    &:hover {
      background-color: #${COLOR.lightGray};
    }
  }
`;

export default function SearchBar() {
  const [isOpen, setIsOpen] = useState(false);
  const [searchInput, setSearchInput] = useState('is:open');

  const handleClick = event => {
    event.preventDefault();
    setIsOpen(!isOpen);
  };

  const handleChange = event => {
    const { value } = event.target;
    setSearchInput(value);
  };
  return (
    <Wrapper>
      <FilterTab>
        <button onClick={handleClick}>Filter ▾</button>
        {isOpen && <SelectModal {...{ setIsOpen, setSearchInput }} />}
      </FilterTab>
      <Search>
        <SearchIcon />
      </Search>
      <input type="text" value={searchInput} onChange={handleChange} />
    </Wrapper>
  );
}
