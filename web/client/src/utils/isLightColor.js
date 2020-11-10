const isLightColor = color => {
  const [_, r, g, b] = color
    .split(/([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})/)
    .map(hex => parseInt(hex, 16));
  return r * 0.299 + g * 0.587 + b * 0.114 > 186;
};

export default isLightColor;
