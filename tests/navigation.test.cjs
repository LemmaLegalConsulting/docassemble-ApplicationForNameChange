const {test} = require('node:test');
const assert = require('node:assert/strict');
const waitUntilContinued = require('./navigation.cjs');
const ok = {ok: true, was_found: false};
function state(overrides = {}) {
  return {
    timeout: 100,
    page: {url: () => '/interview'},
    checkForError: async () => ok,
    get_page_id: async () => 'review',
    throw_system_error: async () => {},
    throw_invalid_answer: async () => {},
    ...overrides,
  };
}
test('Resume completes when the question changes at the same URL', async () => {
  assert.equal(await waitUntilContinued(state(), {url: '/interview', id: 'edit'}), ok);
});
test('ordinary URL navigation completes even when the question ID repeats', async () => {
  assert.equal(await waitUntilContinued(state(), {url: '/previous', id: 'review'}), ok);
});
test('no navigation fails instead of silently continuing', async () => {
  await assert.rejects(waitUntilContinued(state({timeout: 1}), {url: '/interview', id: 'review'}), /No question or URL change/);
});
for (const type of ['system', 'user']) {
  test(type + ' errors retain ALKiln failure behavior', async () => {
    const error = {ok: false, was_found: true, type};
    const reject = async (_state, {error_data}) => {
      assert.equal(error_data, error);
      throw Error(type + ' error');
    };
    const callbacks = type === 'system' ? {throw_system_error: reject} : {throw_invalid_answer: reject};
    await assert.rejects(waitUntilContinued(state({checkForError: async () => error, ...callbacks}), {url: '/previous', id: 'edit'}), new RegExp(type + ' error'));
  });
}
test('a replaced document retries the read-only query', async () => {
  let attempts = 0;
  const s = state({timeout: 500, get_page_id: async () => {
    if (attempts++ === 0) throw Error('Execution context was destroyed');
    return 'review';
  }});
  assert.equal(await waitUntilContinued(s, {url: '/interview', id: 'edit'}), ok);
  assert.equal(attempts, 2);
});
test('unrelated browser errors are not retried or hidden', async () => {
  await assert.rejects(waitUntilContinued(state({get_page_id: async () => {throw Error('Target closed');}}), {url: '/interview', id: 'edit'}), /Target closed/);
});
