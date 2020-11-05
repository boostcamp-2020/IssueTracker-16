import React from 'react';
import LabelListNav from '../components/labelList/LabelListNav';
import LabelList from '../components/labelList/LabelList';

export default function LabelListPage() {
  return (
    <div>
      <LabelListNav />
      <br /> <br />
      <LabelList />
    </div>
  );
}
