const cookies = {
  getCookies() {
    return document.cookie.split('; ').reduce((coockies, keyVal) => {
      const [key, val] = keyVal.split('=');
      return keyVal ? { ...coockies, [key]: val } : coockies;
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
