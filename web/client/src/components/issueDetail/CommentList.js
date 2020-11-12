import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';
import CommentItem from './CommentItem';

const Div = styled.div`
  border-bottom: 2px solid #${COLOR.lightGray};
  margin-bottom: 15px;
`;

export default function CommentList({ comments, author }) {
  const loginNum = 1;
  return (
    <Div>
      {comments.length &&
        comments.map(comment => {
          const isMine = comment.writer.num === loginNum;
          const isAuthor = comment.writer.num === author.num;
          return (
            <CommentItem
              key={comment.num}
              {...{ ...comment, isMine, isAuthor }}
            />
          );
        })}
    </Div>
  );
}
