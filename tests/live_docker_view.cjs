// Read-only live view of the actual Docker test browser. Never changes its viewport.
const fs=require('node:fs');
const path=require('node:path');
const puppeteer=require(path.join(process.env.ALKILN_PATH,'node_modules/puppeteer'));
const output=process.env.LIVE_VIEW_OUTPUT || '/tmp/config/live';
const logfile=process.env.ALKILN_LOG_PATH || '/tmp/namechange-local.log';
fs.mkdirSync(output,{recursive:true});
fs.writeFileSync('/tmp/namechange-live-view.pid',String(process.pid));
let browser,current;
const sleep=ms=>new Promise(resolve=>setTimeout(resolve,ms));
(async()=>{
 for(;;){
  try{
   const text=fs.readFileSync(logfile,'utf8').replace(/\x1b\[[0-9;]*m/g,'');
   const names=[...text.matchAll(/Scenario: ([^\n:]+)/g)].map(match=>match[1]);
   const result=text.match(/(\d+) scenarios? \(([^\n]+)\)/);
   const status=result?{state:'complete',summary:result[1]+' scenarios · '+result[2]}:{state:'running',summary:names.length?'Scenario '+names.length+' · '+names.at(-1):'Starting Docker browser tests'};
   fs.writeFileSync(path.join(output,'status.json'),JSON.stringify(status));
   const profiles=fs.readdirSync('/tmp').filter(name=>name.startsWith('puppeteer_dev_chrome_profile-')).map(name=>path.join('/tmp',name,'DevToolsActivePort')).filter(file=>fs.existsSync(file)).sort((a,b)=>fs.statSync(b).mtimeMs-fs.statSync(a).mtimeMs);
   if(profiles.length&&(!browser?.connected||current!==profiles[0])){
    if(browser?.connected)browser.disconnect();
    current=profiles[0];
    const port=fs.readFileSync(current,'utf8').split('\n')[0];
    browser=await puppeteer.connect({browserURL:'http://127.0.0.1:'+port,defaultViewport:null});
   }
   if(browser?.connected){
    const page=(await browser.pages()).find(page=>page.url().includes('/interview'));
    if(page){
     await page.screenshot({path:path.join(output,'pending.jpg'),type:'jpeg',quality:85});
     fs.renameSync(path.join(output,'pending.jpg'),path.join(output,'frame.jpg'));
    }
   }
  }catch{}
  await sleep(1000);
 }
})();
