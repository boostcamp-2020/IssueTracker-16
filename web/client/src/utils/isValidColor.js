const isValidColor = color =>
  /(^#[0-9A-Fa-f]{6}$)|(^#[0-9A-Fa-f]{3}$)/.test(color);

export default isValidColor;
