import React from 'react';
import styled from 'styled-components';

const Button = styled.button``;

export default function FormButton({ name, onClick }) {
  return <Button onClick={e => onClick(e)}>{name}</Button>;
}
