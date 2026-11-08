const test = require('node:test');
const assert = require('node:assert');
const { add, greet } = require('./app');

test('add works', () => {
  assert.strictEqual(add(2, 3), 5);
});

test('add handles negatives', () => {
  assert.strictEqual(add(-1, 1), 0);
});

test('greet works', () => {
  assert.strictEqual(greet('World'), 'Hello, World!');
});
