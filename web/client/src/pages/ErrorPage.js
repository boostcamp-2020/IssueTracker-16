import React from 'react';
import Helmet from 'react-helmet';
import styled from 'styled-components';

const Wrapper = styled.div`
  position: relative;
  height: 100vh;

  > div {
    max-width: 710px;
    width: 100%;
    text-align: center;
    padding: 0px 15px;
    line-height: 1.4;
    position: absolute;
    left: 50%;
    top: 50%;
    -webkit-transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
  }
`;

const Message = styled.div`
  height: 200px;
  line-height: 200px;

  > h1 {
    font-family: 'Fredoka One', cursive;
    font-size: 168px;
    margin: 0px;
    color: #ff508e;
    text-transform: uppercase;
  }
`;

const Link = styled.a`
  font-family: 'Raleway', sans-serif;
  display: inline-block;
  font-weight: 700;
  border-radius: 15px;
  text-decoration: none;
  color: #39b1cb;
`;

const Arrow = styled.span`
  position: relative;
  top: -2px;
  border: solid #39b1cb;
  border-width: 0 3px 3px 0;
  display: inline-block;
  padding: 3px;
  -webkit-transform: rotate(135deg);
  -ms-transform: rotate(135deg);
  transform: rotate(135deg);
`;

export default function ErrorPage({ match }) {
  const codes = ['404', '500'];
  let code = match.params.code;
  if (!codes.includes(code)) {
    window.location.href = '/error/404';
    code = 404;
  }
  return (
    <>
      <Helmet>
        <title>Error Page {code}</title>
      </Helmet>
      <Wrapper>
        <div>
          <Message>
            <h1>{code}</h1>
          </Message>
          <Link href="/">
            <Arrow></Arrow>Return To Homepage
          </Link>
        </div>
      </Wrapper>
    </>
  );
}
