import React from 'react';
import Label from './Label';

export default function LabelItem() {
  return (
    <div>
      <Label />
      <span>[description] </span>
      <div>
        <button>Edit</button>
        <button>Delete</button>
      </div>
    </div>
  );
}
