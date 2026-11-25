const {test}=require('node:test');
const assert=require('node:assert/strict');
const assertNoPageExpiry=require('./page_expiry.cjs');
const page=messages=>({$$eval:async(selector,evaluate)=>{
 assert.equal(selector,'.alert');return evaluate(messages.map(textContent=>({textContent})));
}});
test('a success-styled expiry alert rejects the run instead of resubmitting input',async()=>{
 await assert.rejects(assertNoPageExpiry(page(['Input not processed because the page expired.'])),/rejected input/);
});
test('ordinary informational alerts do not fail the run',async()=>{
 await assertNoPageExpiry(page(['Your progress was saved.']));
 await assertNoPageExpiry(page([]));
});
test('browser failures remain failures',async()=>{
 await assert.rejects(assertNoPageExpiry({$$eval:async()=>{throw Error('Target closed');}}),/Target closed/);
});
