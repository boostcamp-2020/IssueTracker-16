import React, { useContext } from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import SearchIcon from '../../../statics/svg/searchIcon';
import FilterButton from './FilterButton';
import {
  SearchInputContext,
  SetSearchInputContext,
} from '../../../pages/IssueListPage';

const Wrapper = styled.div`
  width: 68%;
  display: flex;
  align-items: center;
`;

const Search = styled.div`
  width:32px;
  height:30px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-top: 1px solid #e1e4e8;
  border-bottom: 1px solid #e1e4e8;
  background-color: #${COLOR.backGray};
  

  svg {
    fill: #${COLOR.darkGray}};
  }
`;

const Form = styled.form`
  width: 90%;
  background-color: transparent;
  border: none;
  input[type='text'] {
    height: 30px;
    width: 100%;
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

export default function SearchBar() {
  const searchInput = useContext(SearchInputContext);
  const setSearchInput = useContext(SetSearchInputContext);

  const handleChange = event => {
    const { value } = event.target;
    setSearchInput(value);
  };

  return (
    <Wrapper>
      <FilterButton />
      <Search>
        <SearchIcon />
      </Search>
      <Form>
        <input type="text" value={searchInput} onChange={handleChange} />
      </Form>
    </Wrapper>
  );
}
