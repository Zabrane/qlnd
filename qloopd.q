p)import base64, codecs, json, requests, os
p)url = 'http://localhost:8081/v1/loop/'
p)LND_DIR = os.getenv('LND_DIR', os.getenv('HOME')+'/.lnd')
p)cert_path =  LND_DIR+'/tls.cert'


p)def loopOutTerms():
  endpoint = 'out/terms'
  r = requests.get(url+endpoint, verify=cert_path)
  return r.json()

p)def loopOutQuote(amt):
  endpoint = 'out/quote/'+amt+'?conf_target=2'
  r = requests.get(url+endpoint, verify=cert_path)
  return r.json()

p)def loopInTerms():
  endpoint = 'in/terms'
  r = requests.get(url+endpoint, verify=cert_path)
  return r.json()

p)def loopInQuote(amt='200000'):
  endpoint = 'in/quote/'+amt
  r = requests.get(url+endpoint, verify=cert_path)
  return r.json()

p)def loopIn(data):
  endpoint = 'in'
  r = requests.post(url+endpoint, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def loopOut(data):
  endpoint = 'out'
  r = request.post(url+endpoint, verify=cert_path, data=json.dumps(data))
  return r.json()

q).loopd.loopOutTerms:.p.get[`loopOutTerms;<]
q).loopd.loopOutQuote:.p.get[`loopOutQuote;<]
q).loopd.loopInTerms:.p.get[`loopInTerms;<]
q).loopd.loopInQuote:.p.get[`loopInQuote;<]
q).loopd.loopIn:.p.get[`loopIn;<]
q).loopd.loopOut:.p.get[`loopOut;<]
