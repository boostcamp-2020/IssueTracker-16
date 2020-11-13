import React, { useContext, useState, useEffect } from 'react';
import axios from 'axios';
import styled from 'styled-components';
import { useHistory } from 'react-router-dom';

import COLOR from '../../../utils/color';
import {
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

export default function MilestoneList({ setIsOpen }) {
  const [milestones, setMilestones] = useState([]);
  const history = useHistory();
  const setCheckItems = useContext(SetCheckItemsContext);
  const setSearchInput = useContext(SetSearchInputContext);

  const handleClickSelect = (event, title) => {
    event.preventDefault();
    setCheckItems([]);
    setSearchInput(`is:open milestone:${title}`);
    setIsOpen(false);
    history.push(`/issues?is=open&milestone=${title}`);
  };

  useEffect(() => {
    const getMilestones = () => axios('/api/milestones');
    getMilestones().then(({ data }) => setMilestones(data.milestones));
  }, []);

  return (
    <Wrapper>
      {milestones.length ? (
        milestones.map(milestone => (
          <button
            key={milestone.num}
            onClick={event => handleClickSelect(event, milestone.title)}
          >
            {milestone.title}
          </button>
        ))
      ) : (
        <h3>We couldn’t find anything!</h3>
      )}
    </Wrapper>
  );
}
