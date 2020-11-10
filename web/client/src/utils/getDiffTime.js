const SECOND = 1000;
const MINUTE = SECOND * 60;
const HOUR = MINUTE * 60;
const DAY = HOUR * 24;

const convertSec = diff => ~~(diff / SECOND);
const convertMin = diff => ~~(diff / MINUTE);
const convertHour = diff => ~~(diff / HOUR);
const convertDay = diff => ~~(diff / DAY);

const getDiffTime = time => {
  const diff = new Date() - new Date(time);
  const diffDay = convertDay(diff);
  if (diffDay >= 1) {
    return `${diffDay} days ago`;
  }
  const diffHour = convertHour(diff);
  if (diffHour >= 1) {
    return `${diffHour} hours ago`;
  }
  const diffMin = convertMin(diff);
  if (diffMin >= 1) {
    return `${diffMin} minutes ago`;
  }
  const diffSec = convertSec(diff);
  return `${diffSec} seconds ago`;
};

export default getDiffTime;
