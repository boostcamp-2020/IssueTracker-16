import React from 'react';
import Helmet from 'react-helmet';

import Header from '../components/common/Header';
import LabelListNav from '../components/labelList/LabelListNav';
import LabelList from '../components/labelList/LabelList';

export default function LabelListPage() {
  return (
    <>
      <Helmet>
        <title>Issue Tracker - Label</title>
      </Helmet>
      <Header />
      <div>
        <LabelListNav />
        <br /> <br />
        <LabelList />
      </div>
    </>
  );
}