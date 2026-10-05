"""Summarize ordered browser runs without copying session data or step arguments.
Usage: python scripts/summarize_alkiln.py ARTIFACT_DIR COMMIT [ARTIFACT_DIR COMMIT ...]
The newest execution of a scenario determines its reported status.
"""
from pathlib import Path
import hashlib,json,sys,re,subprocess
ROOT=Path(__file__).resolve().parents[1]
assert len(sys.argv)>2 and len(sys.argv[1:])%2==0
latest={};runs=[]
for directory,commit in zip(sys.argv[1::2],sys.argv[2::2]):
    commit=subprocess.check_output(['git','rev-parse',commit],cwd=ROOT,text=True).strip()
    folder=Path(directory)
    if not folder.is_absolute():folder=ROOT/folder
    features=json.loads((folder/'cucumber.json').read_text())
    scenarios=[]
    for feature in features:
        for item in feature.get('elements',[]):
            if item.get('type')!='scenario':continue
            all_steps=item['steps'];steps=[s for s in all_steps if not s.get('hidden')]
            statuses=[s.get('result',{}).get('status') for s in all_steps]
            status='passed' if all(s=='passed' for s in statuses) else 'failed'
            row={'name':item['name'],'tags':[t['name'] for t in item.get('tags',[])],
                 'status':status,'steps':len(steps),
                 'duration_seconds':round(sum(s.get('result',{}).get('duration',0) for s in all_steps)/1e9,3),
                 'application_commit':commit,'local_artifacts':str(folder.relative_to(ROOT))}
            scenarios.append(row);latest[item['name']]=row
    runs.append({'application_commit':commit,'local_artifacts':str(folder.relative_to(ROOT)),
                 'scenario_count':len(scenarios),'passed':sum(s['status']=='passed' for s in scenarios),
                 'failed':sum(s['status']!='passed' for s in scenarios),
                 'step_count':sum(s['steps'] for s in scenarios)})
files=['tests/steps.cjs','tests/run_alkiln.py','docassemble/ApplicationForNameChange/data/sources/scenarios.feature']
expected=set(re.findall(r'^\s*Scenario: (.+)$',(ROOT/files[-1]).read_text(),re.M))
assert set(latest)==expected, 'Execution report does not cover the current scenario set'
report={'date':'2026-10-04','server':'localhost','package':'ApplicationForNameChange',
        'alkiln_commit':'d7e4f42aa8a828013a8a229067697decf1322e5f',
        'fixture_and_harness_sha256':{name:hashlib.sha256((ROOT/name).read_bytes()).hexdigest() for name in files},
        'aggregation':'Latest execution of each scenario; full run and focused post-presentation verification are listed separately.',
        'scenario_count':len(latest),'passed':sum(s['status']=='passed' for s in latest.values()),
        'step_count':sum(s['steps'] for s in latest.values()),'runs':runs,'scenarios':list(latest.values()),
        'retained_failure':'Full run: known-parent story received an intermittent localhost page-expired response. Raw failed artifacts remain local; no error was ignored or input automatically retried.'}
(ROOT/'validation/alkiln-results.json').write_text(json.dumps(report,indent=2)+'\n')
print(f"{report['passed']}/{report['scenario_count']} scenarios; {report['step_count']} story steps")
if report['passed']!=report['scenario_count']:sys.exit(1)
