const randomValueNotInArray = (array) => {
  let e;
  do {
    e = Math.ceil(Math.random() * 31); // n + 1
  } while (array.includes(e))
  return e;
}

module.exports = {
  randomValueNotInArray
};