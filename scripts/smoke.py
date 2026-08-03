#!/usr/bin/env python3
import os,re,requests,urllib.parse
base=os.environ['BASE_URL'].rstrip('/');user=os.environ['ADMIN_USER'];password=os.environ['ADMIN_PASSWORD']
health=requests.get(base+'/health.ashx',timeout=30);assert health.status_code==200 and health.text.strip().lower()=='ok'
missing=requests.get(base+'/railway-missing-resource',timeout=30);assert missing.status_code==404
session=requests.Session();page=session.get(base+'/',timeout=30);assert page.status_code==200 and 'MeshCentral' in page.text
# MeshCentral login uses action=login and redirects authenticated users to the management UI.
r=session.post(base+'/',data={'action':'login','username':user,'password':password},allow_redirects=True,timeout=45);assert r.status_code==200 and ('logout' in r.text.lower() or 'My Devices' in r.text),r.url
print('MeshCentral smoke checks passed')
