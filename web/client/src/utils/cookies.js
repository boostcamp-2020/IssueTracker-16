const cookies = {
  getCookies() {
    return document.cookie.split('; ').reduce((cookies, keyVal) => {
      const [key, val] = keyVal.split('=');
      return keyVal ? { ...cookies, [key]: val } : cookies;
    }, {});
  },
  setCookie(key, val) {
    document.cookie = `${key}=${val}`;
  },
  deleteCookie(key) {
    this.setCookie(key, '; expires=Thu, 01 Jan 1999 00:00:10 GMT;');
  },
};

export default cookies;
