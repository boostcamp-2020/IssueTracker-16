import React, { useState } from 'react';
import styled from 'styled-components';

import COLOR from '../../../utils/color';

const Wrapper = styled.div`
  display: flex;
  position: relative;

  div {
    border: none;
  }
`;
const ProfileImage = styled.img`
  width: 20px;
  height: 20px;
  border-radius: 50%;
  cursor: pointer;
`;
const Assignees = styled.div`
  position: absolute;
  bottom: 4px;
  right: 16px;
  line-height: 1;
  width: max-content;
  padding: 0.5em 0.75em;
  font-size: 11px;
  border: none;
  border-radius: 6px;
  background-color: #${COLOR.black};
  color: #${COLOR.white};
`;
const Arrow = styled.span`
  position: absolute;
  bottom: 17px;
  right: 21px;
  -webkit-transform: rotate(-180deg);
  -moz-transform: rotate(-180deg);
  -o-transform: rotate(-180deg);
  transform: rotate(-180deg);
  ms-filter: 'progid:DXImageTransform.Microsoft.BasicImage(rotation=2)';
  filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=2);
`;

export default function AssigneeTag({ assignees }) {
  const [isHover, setIsHover] = useState(false);
  const handleMouseOver = () => {
    setIsHover(true);
  };
  const handleMouseOut = () => {
    setIsHover(false);
  };
  return (
    <Wrapper>
      {assignees.map(a => (
        <div
          onMouseOver={handleMouseOver}
          onMouseOut={handleMouseOut}
          key={a.num}
        >
          <ProfileImage src={a.imageUrl} alt={a.id} />
        </div>
      ))}
      {isHover && !!assignees.length && (
        <>
          <Arrow>▾</Arrow>
          <Assignees>{`Assigned to ${
            assignees.length === 1
              ? assignees[0].id
              : getAssigneesStr(assignees)
          }`}</Assignees>
        </>
      )}
    </Wrapper>
  );
}

const getAssigneesStr = assignees => {
  const firstAssignee = assignees[0].id;
  const lastAssignee = assignees[assignees.length - 1].id;
  const str = assignees.reduce(
    (str, assignee) =>
      firstAssignee === assignee.id
        ? firstAssignee
        : lastAssignee === assignee.id
        ? `${str} and ${lastAssignee}`
        : `${str}, ${assignee.id}`,
    '',
  );
  return str;
};
