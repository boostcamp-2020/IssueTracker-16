import React, { useState } from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';
import SearchIcon from '../../../statics/svg/searchIcon';
import SelectModal from './SelectModal';
const Wrapper = styled.div`
  width: 68%;
  display: flex;
  align-items: center;

  > div {
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
  }

  input[type='text'] {
    height: 30px;
    width: 90%;
    padding: 5px 12px 5px 0;
    border: 1px solid #e1e4e8;
    border-left: none;
    border-radius: 0 6px 6px 0;
    outline: none;
    font-size: 14px;
  }
`;
const FilterTab = styled.details`
  min-width: 90px;

  summary::-webkit-details-marker {
    display: none;
  }
  summary {
    height: 30px;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #e1e4e8;
    border-radius: 6px 0 0 6px;
    cursor: pointer;
    outline: none;
    font-size: 14px;
    color: #${COLOR.darkGray};
  }
`;

export default function SearchBar() {
  return (
    <Wrapper>
      <FilterTab>
        <summary>Filters ▾</summary>
        <details-menu>
          <SelectModal />
        </details-menu>
      </FilterTab>
      <div>
        <SearchIcon />
      </div>
      <input type="text" />
    </Wrapper>
  );
}
