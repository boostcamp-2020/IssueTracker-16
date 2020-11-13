import React, { useContext } from 'react';
import styled from 'styled-components';

import { CheckItemsContext } from '../../../pages/IssueListPage';

import COLOR from '../../../utils/color';

const Count = styled.span`
  color: #${COLOR.darkGray};
`;

const Options = styled.div`
  display: flex;
  justify-content: flex-end;

  > span {
    margin-left: 16px;
  }
`;
const Option = styled.span`
  font-size: 14px;
  display: inline;

  svg {
    margin-right: 3px;
  }

  a {
    display: flex;
    align-items: center;
    color: #${COLOR.black};
    text-decoration: none;
  }
`;

export default function SelectedOption() {
  const checkItems = useContext(CheckItemsContext);
  return (
    <>
      <Count>{checkItems.length} selected</Count>
      <Options>
        <Option>Mark as▾ </Option>
        <Option>Label▾ </Option>
        <Option>Milestone▾ </Option>
        <Option>Assignee▾ </Option>
      </Options>
    </>
  );
}
