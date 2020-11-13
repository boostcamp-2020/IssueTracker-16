import React, { useContext } from 'react';
import styled from 'styled-components';

import { CheckItemsContext } from '../../../pages/IssueListPage';

import ListHeader from '../../common/ListHeader';
import MainOption from './MainOption';
import SelectedOption from './SelectedOption';

const CheckBox = styled.div`
  margin-right: 16px;
`;
const Options = styled.div`
  width: 100%;
  display: flex;
  justify-content: space-between;
`;

export default function IssueListHeader({
  open,
  closed,
  issues,
  handleAllCheck,
}) {
  const checkItems = useContext(CheckItemsContext);
  return (
    <ListHeader isIssueList={true}>
      <CheckBox>
        <input
          type="checkbox"
          onChange={event => handleAllCheck(event.target.checked)}
          checked={
            issues.length
              ? issues.length === checkItems.length
                ? true
                : false
              : false
          }
        />
      </CheckBox>
      <Options>
        {checkItems.length ? (
          <SelectedOption />
        ) : (
          <MainOption {...{ open, closed }} />
        )}
      </Options>
    </ListHeader>
  );
}
