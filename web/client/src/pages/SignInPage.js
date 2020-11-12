import React from 'react';
import styled from 'styled-components';

import COLOR from '../utils/color';
import Octicon from '../statics/svg/octicon';

const Container = styled.div`
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background-color: #${COLOR.backGray};
`;

const Contents = styled.div`
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -60%);
  width: 300px;
`;

const TitleContainer = styled.div`
  width: 100%;
  text-align: center;
  padding: 25px 0;
`;

const TitleContents = styled.span`
  font-size: 30px;
  font-weight: 700;
`;

const BodyContainer = styled.div`
  width: 100%;
  padding: 25px 0;
  border: 1px solid #${COLOR.darkGray};
  border-radius: 5px;
  background-color: #${COLOR.white};
  text-align: center;
`;

const GitHubButtonContainer = styled.a`
  display: inline-block;
  width: 80%;
  padding: 10px 0;
  border-radius: 5px;
  background-color: #888888;
  text-align: center;
  text-decoration: none;
`;

const GitHubButtonContents = styled.span`
  position: relative;
  color: #${COLOR.lightGray};
  font-weight: 600;

  > .octicon {
    position: absolute;
    top: -20%;
    right: -25%;
  }
`;

export default function SignInPage() {
  return (
    <Container>
      <Contents>
        <TitleContainer>
          <TitleContents>이슈 트래커</TitleContents>
        </TitleContainer>
        <BodyContainer>
          <GitHubButtonContainer href="/api/auths/oauth/gitHub">
            <GitHubButtonContents>
              Sign in with GitHub
              <Octicon width={24} height={24} />
            </GitHubButtonContents>
          </GitHubButtonContainer>
        </BodyContainer>
      </Contents>
    </Container>
  );
}
