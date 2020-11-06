import React from 'react';
import Helmet from 'react-helmet';
import styled from 'styled-components';

import Header from '../components/common/Header';
import LabelListNav from '../components/labelList/LabelListNav';
import LabelList from '../components/labelList/LabelList';

const LabelListPageElement = styled.div`
  width: 900px;
  margin: 0 auto;
`;

export default function LabelListPage() {
  return (
    <>
      <Helmet>
        <title>Issue Tracker - Label</title>
      </Helmet>
      <Header />
      <LabelListPageElement>
        <LabelListNav />
        <br /> <br />
        <LabelList />
      </LabelListPageElement>
    </>
  );
}
