import React, { useContext, useState, useEffect } from 'react';
import axios from 'axios';
import styled from 'styled-components';
import { useHistory, useLocation } from 'react-router-dom';

import COLOR from '../../../utils/color';
import {
  SearchInputContext,
  SetSearchInputContext,
  SetCheckItemsContext,
} from '../../../pages/IssueListPage';

const Wrapper = styled.div`
  display: flex;
  flex-direction: column;

  button {
    padding: 7px 30px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    border: none;
    border-top: 1px solid #${COLOR.lightGray};
    background-color: transparent;
    color: #${COLOR.black};
    outline: none;
    font-size: 12px;
    cursor: pointer;
  }
`;
const Color = styled.div`
  width: 20px;
  height: 20px;
  margin-right: 5px;
  border-radius: 50%;
  background-color: #${({ color }) => color};
`;

export default function LabelList({ setIsOpen }) {
  const history = useHistory();
  const location = useLocation();

  const [labels, setLabels] = useState([]);
  const searchInput = useContext(SearchInputContext);
  const setCheckItems = useContext(SetCheckItemsContext);
  const setSearchInput = useContext(SetSearchInputContext);

  const handleClickSelect = (event, name) => {
    event.preventDefault();
    setCheckItems([]);
    setSearchInput(`${searchInput} label:${name}`);
    setIsOpen(false);
    history.push(
      `/issues${
        location.search.length ? `${location.search}&` : '?'
      }label=${name}`,
    );
  };

  useEffect(() => {
    const getLabels = () => axios('/api/labels');
    getLabels().then(({ data }) => setLabels(data));
  }, []);

  return (
    <Wrapper>
      {labels.length ? (
        labels.map(label => (
          <button
            key={label.num}
            onClick={event => handleClickSelect(event, label.name)}
          >
            <Color color={label.color}></Color>
            <span>{label.name}</span>
          </button>
        ))
      ) : (
        <h3>We couldn’t find anything!</h3>
      )}
    </Wrapper>
  );
}
