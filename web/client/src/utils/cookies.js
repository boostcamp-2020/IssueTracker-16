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
    this.setCookie(key, '');
  },
};

export default cookies;
