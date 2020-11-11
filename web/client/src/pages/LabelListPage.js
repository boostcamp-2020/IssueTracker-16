import React, { useState } from 'react';
import Helmet from 'react-helmet';

import ListPage from '../components/common/ListPage';
import Header from '../components/common/Header';
import LabelListNav from '../components/labelList/LabelListNav';
import LabelList from '../components/labelList/LabelList';
import LabelInput from '../components/labelList/LabelInput/LabelInput';

export default function LabelListPage() {
  const [state, setState] = useState({ isHidden: true });

  return (
    <>
      <Helmet>
        <title>Issue Tracker - Label</title>
      </Helmet>
      <Header />
      <ListPage>
        <LabelListNav {...{ ...state, setState }} />
        {!state.isHidden && <LabelInput />}
        <LabelList />
      </ListPage>
    </>
  );
}
