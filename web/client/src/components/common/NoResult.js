import React from 'react';
import styled from 'styled-components';

import COLOR from '../../utils/color';
import MilestoneLogo from '../../statics/svg/milestone';
import LabelLogo from '../../statics/svg/label';
import OpenIssueLogo from '../../statics/svg/openIssue';

const Div = styled.div`
  height: 300px;
  padding: 32px;
  margin-top: 60px;
  border: none;
  background-color: transparent;
  text-align: center;

  svg {
    width: 32px;
    height: 32px;
    fill: #${COLOR.darkGray};
  }

  h3 {
    margin-top: 30px;
    font-size: 20px;
    font-weight: 500;
    display: block;
  }
`;

export default function NoResult({ page }) {
  return (
    <Div>
      {page === 'issue' ? (
        <>
          <OpenIssueLogo />
          <h3>No results matched your search.</h3>
        </>
      ) : page === 'label' ? (
        <>
          <LabelLogo />
          <h3>We couldn’t find anything!</h3>
        </>
      ) : (
        <>
          <MilestoneLogo />
          <h3>We couldn’t find anything!</h3>
        </>
      )}
    </Div>
  );
}
