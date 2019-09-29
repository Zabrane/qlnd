p)import base64, codecs, json, requests, os, socket
p)loopip = socket.gethostbyname(socket.gethostname())
p)loopurl = 'http://'+loopip+':8081/v1/loop/'
p)loop_lnd_dir = os.getenv('LND_DIR', os.getenv('HOME')+'/.lnd')
p)cert_path = loop_lnd_dir+'/tls.cert'

p)def setURL(new_url):
  global loopurl
  loopurl = new_url
  return loopurl

p)def setTLS(new_cert_path):
  global cert_path
  cert_path = new_cert_path
  return cert_path

p)def loopOutTerms():
  endpoint = 'out/terms'
  r = requests.get(loopurl+endpoint, verify=cert_path)
  return r.json()

p)def loopOutQuote(amt):
  endpoint = 'out/quote/'+amt+'?conf_target=2'
  r = requests.get(loopurl+endpoint, verify=cert_path)
  return r.json()

p)def loopInTerms():
  endpoint = 'in/terms'
  r = requests.get(loopurl+endpoint, verify=cert_path)
  return r.json()

p)def loopInQuote(amt='200000'):
  endpoint = 'in/quote/'+amt
  r = requests.get(loopurl+endpoint, verify=cert_path)
  return r.json()

p)def loopIn(data):
  endpoint = 'in'
  r = requests.post(loopurl+endpoint, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def loopOut(data):
  endpoint = 'out'+'?conf_target=2'
  r = requests.post(loopurl+endpoint, verify=cert_path, data=json.dumps(data))
  return r.json()

q).loopd.setURL:.p.get[`setURL;<]
q).loopd.setTLS:.p.get[`setTLS;<]
q).loopd.loopOutTerms:.p.get[`loopOutTerms;<]
q).loopd.loopOutQuote:.p.get[`loopOutQuote;<]
q).loopd.loopInTerms:.p.get[`loopInTerms;<]
q).loopd.loopInQuote:.p.get[`loopInQuote;<]
q).loopd.loopIn:.p.get[`loopIn;<]
q).loopd.loopOut:.p.get[`loopOut;<]
