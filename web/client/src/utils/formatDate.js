const months = [
  undefined,
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const formatDate = fullDate => {
  const [year, month, date] = fullDate.split('-');
  return `${months[month]} ${date}, ${year}`;
};

export default formatDate;
