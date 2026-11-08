function add(a, b) {
  return a + b;
}

function greet(name) {
  return `Hello, ${name}!`;
}

module.exports = { add, greet };

if (require.main === module) {
  console.log(greet('Jenkins'));
  console.log('2 + 3 =', add(2, 3));
}
