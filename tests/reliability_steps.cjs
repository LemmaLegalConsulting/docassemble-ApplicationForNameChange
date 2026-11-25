const path=require('node:path');
const fs=require('node:fs');
const alk=process.env.ALKILN_PATH;
const {Before,After,When,Then}=require(path.join(alk,'node_modules/@cucumber/cucumber'));
const scope=require(path.join(alk,'lib/scope'));
// Keep request timing and token fingerprints, never cookies, tokens, or session URLs.
const crypto=require('node:crypto');
const fingerprint=value=>value?crypto.createHash('sha256').update(value).digest('hex').slice(0,12):null;
let scenarioContext;
Before(async function(){
 // ALKiln reuses a browser; isolate cookies and storage between scenarios.
 // Close the preceding context after ALKiln has saved its failure artifacts.
 if(scenarioContext)await scenarioContext.close();
 await scope.page.close();
 scenarioContext=await scope.browser.createBrowserContext();
 scope.page=await scenarioContext.newPage();
 const trace=[]; this.editingTrace=trace; this.tracePending=[];
 this.traceRequest=req=>{
  const url=new URL(req.url());
  if(url.origin!==new URL(scope.page.url()).origin)return;
  const data=new URLSearchParams(req.postData()||'');
  trace.push({event:'request',time:Date.now(),path:url.pathname,method:req.method(),question:data.get('_question_name'),tracker:data.get('_tracker'),csrf:fingerprint(data.get('csrf_token')),cookie:fingerprint(req.headers().cookie)});
 };
 this.traceResponse=res=>{
  const url=new URL(res.url());
  if(url.origin!==new URL(scope.page.url()).origin)return;
  const row={event:'response',time:Date.now(),path:url.pathname,status:res.status(),cookie:fingerprint(res.headers()['set-cookie'])};trace.push(row);
  if((res.headers()['content-type']||'').includes('application/json'))this.tracePending.push(res.text().then(body=>{if(body.includes('csrf_error'))row.reason='csrf_error';}).catch(()=>{}));
 };
 scope.page.on('request',this.traceRequest);scope.page.on('response',this.traceResponse);
});
After(async function(){
 scope.page.off('request',this.traceRequest);scope.page.off('response',this.traceResponse);
 await Promise.all(this.tracePending);
 fs.writeFileSync(path.join(scope.paths.scenario,'submission-trace.json'),JSON.stringify(this.editingTrace,null,2));
});
When('I archive the downloaded PDF {string} as {string}',async(file,archive)=>{
 if(path.basename(file)!==file||path.basename(archive)!==archive)throw Error('Use filenames only');
 fs.renameSync(path.join(scope.paths.scenario,file),path.join(scope.paths.scenario,archive));
});
Then('the packet offers {string}',async(file)=>{
 const links=await scope.page.$$eval('#daquestion a',els=>els.map(el=>el.href));
 if(!links.some(h=>new URL(h).searchParams.get('filename')===file || h.includes(encodeURIComponent(file))))throw Error('Missing packet download: '+file);
});
Then('the packet does not offer {string}',async(file)=>{
 const links=await scope.page.$$eval('#daquestion a',els=>els.map(el=>el.href));
 if(links.some(h=>new URL(h).searchParams.get('filename')===file || h.includes(encodeURIComponent(file))))throw Error('Unexpected packet download: '+file);
});

When('I remove child number {int} from the family list',{timeout:90000},async(number)=>{
 const rows=await scope.page.$$('#daquestion table tbody tr');
 const row=rows[number-1];
 if(!row)throw Error('No child row '+number);
 const links=await row.$$('a');
 const link=await (async()=>{for(const a of links){if((await a.evaluate(el=>el.innerText)).trim()==='Delete')return a;}})();
 if(!link)throw Error('No Delete action for child '+number);
 const dialog=async d=>{if(d.type()!=='confirm')throw Error('Unexpected dialog');await d.accept();};
 scope.page.once('dialog',dialog);
 try{await scope.tapElementAndNavigate(scope,{elem:link});}finally{scope.page.off('dialog',dialog);}
});
