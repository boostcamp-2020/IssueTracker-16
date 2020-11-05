import React from 'react';

import Header from '../components/Header';
import LabelListNav from '../components/labelList/LabelListNav';
import LabelList from '../components/labelList/LabelList';

export default function LabelListPage() {
  return (
    <>
      <Header />
      <div>
        <LabelListNav />
        <br /> <br />
        <LabelList />
      </div>
    </>
  );
}
