// Resume may change the question without changing the interview URL.
module.exports = async function waitUntilContinued(state, {url = '', id = ''}) {
  const previous = id || state.page_id;
  const deadline = Date.now() + state.timeout;
  while (Date.now() < deadline) {
    let error;
    let current;
    try {
      error = await state.checkForError(state);
      current = await state.get_page_id(state);
    } catch (failure) {
      // Only retry read-only queries interrupted by a document replacement.
      if (!String(failure).includes('Execution context was destroyed')) throw failure;
      await new Promise(resolve => setTimeout(resolve, 50));
      continue;
    }
    if (!error.ok) {
      await state.throw_system_error(state, {error_data: error, id: previous});
      await state.throw_invalid_answer(state, {error_data: error, id: previous});
      return error;
    }
    if (state.page.url() !== url || (previous && current && current !== previous)) return error;
    await new Promise(resolve => setTimeout(resolve, 50));
  }
  throw Error('No question or URL change after Continue from ' + previous);
};
