const path=require('node:path');
const fs=require('node:fs');
const {execFileSync}=require('node:child_process');
const alkiln=process.env.ALKILN_PATH;
const {Then}=require(path.join(alkiln,'node_modules/@cucumber/cucumber'));
const scope=require(path.join(alkiln,'lib/scope'));
// Docassemble now uses div.da-button-set instead of fieldset for these controls.
// Restrict the compatibility change to selectors; keep ALKiln navigation/assertions.
scope.continue_button_selector='.da-field-buttons button[type="submit"].btn-primary';
scope.signature_selector='.da-field-buttons .dasigsave';
// New labels omit aria-checked. Read the associated native input instead.
scope.setCheckbox=async (_scope,{label,answer})=>{
 await label.evaluate((el,want)=>{
  const input=el.control||document.getElementById(el.htmlFor);
  if(!input)throw Error('Checkbox label has no associated input');
  if(input.checked!==want)el.click();
 },String(answer).toLowerCase()==='true');
};
const clean=s=>s.replace(/\s+/g,' ').trim();
Then('the downloaded PDF {string} should contain {string}',async(file,expected)=>{
 const pdf=path.join(scope.paths.scenario,file);
 const text=clean(execFileSync('pdftotext',[pdf,'-'],{encoding:'utf8'}));
 if(!text.includes(clean(expected)))throw Error('Missing PDF text: '+expected);
});
Then('the downloaded PDF {string} should not contain {string}',async(file,unwanted)=>{
 const text=clean(execFileSync('pdftotext',[path.join(scope.paths.scenario,file),'-'],{encoding:'utf8'}));
 if(text.includes(clean(unwanted)))throw Error('Unexpected PDF text: '+unwanted);
});
Then('the downloaded PDF {string} should contain {string} exactly {int} times',async(file,expected,count)=>{
 const text=clean(execFileSync('pdftotext',[path.join(scope.paths.scenario,file),'-'],{encoding:'utf8'}));
 const actual=text.split(clean(expected)).length-1;
 if(actual!==count)throw Error('Expected '+count+' occurrences of '+expected+'; found '+actual);
});

// Fail promptly on AssemblyLine's custom error screen instead of repeatedly pressing Next.
const examine=scope.examinePageID;
scope.examinePageID=async(...args)=>{
 const result=await examine(...args);
 if(result.id==='custom-error-action')throw Error('Interview runtime error: '+await scope.page.$eval('#daquestion',e=>e.innerText));
 return result;
};
const {When}=require(path.join(alkiln,'node_modules/@cucumber/cucumber'));
When('I follow the review link containing {string}',{timeout:90000},async(text)=>{
 const links=await scope.page.$$('#daquestion a');
 for(const link of links){
  if((await link.evaluate(e=>e.closest('.da-review')?.innerText || e.innerText)).includes(text)){
   await scope.tapElementAndNavigate(scope,{elem:link});return;
  }
 }
 throw Error('No review link containing: '+text);
});

// Resume can change the question without changing the URL on current Docassemble.
// Keep the normal error checks and require an observable question or URL change.
scope.waitUntilContinued=require('./navigation.cjs');

// A navigation can replace the DOM during a read-only error query. Retry that
// query on the new document; never retry an input action or ignore an error.
const checkForError=scope.checkForError;
scope.checkForError=async (...args)=>{
 for(let attempt=0;attempt<5;attempt++){
  try{
   await require('./page_expiry.cjs')(scope.page);
   return await checkForError(...args);
  }catch(error){
   if(!String(error).includes('Execution context was destroyed')||attempt===4)throw error;
   await new Promise(resolve=>setTimeout(resolve,100));
  }
 }
};

require('./reliability_steps.cjs');
// Repeated PDF assertions must read the newly downloaded version after edits.
When('I discard the previous download {string}', async (file) => {
 if (path.basename(file) !== file) throw Error('Use a download filename without folders');
 fs.unlinkSync(path.join(scope.paths.scenario, file));
});
When('I edit the table row containing {string}', {timeout:90000}, async (text) => {
 const rows=await scope.page.$$('#daquestion table tr');
 for (const row of rows) {
  if (!(await row.evaluate(el=>el.innerText)).includes(text)) continue;
  for (const link of await row.$$('a[role="button"]')) {
   if ((await link.evaluate(el=>el.innerText)).trim()==='Edit') {
    await scope.tapElementAndNavigate(scope,{elem:link});
    return;
   }
  }
 }
 throw Error('No editable table row containing: '+text);
});
When('I delete the table row containing {string}', {timeout:90000}, async (text) => {
 const rows=await scope.page.$$('#daquestion table tr');
 for (const row of rows) {
  if (!(await row.evaluate(el=>el.innerText)).includes(text)) continue;
  for (const link of await row.$$('a[role="button"]')) {
   if ((await link.evaluate(el=>el.innerText)).trim()!=='Delete') continue;
   let confirmed=false;
   const confirm=async dialog=>{
    if(dialog.type()!=='confirm') throw Error('Unexpected dialog while deleting a test row');
    confirmed=true;
    await dialog.accept();
   };
   scope.page.once('dialog',confirm);
   try { await scope.tapElementAndNavigate(scope,{elem:link}); }
   finally { scope.page.off('dialog',confirm); }
   if(!confirmed) throw Error('Expected the row-deletion confirmation');
   return;
  }
 }
 throw Error('No deletable table row containing: '+text);
});
