p)import base64, codecs, json, requests, os
p)url = 'https://217.160.185.97:8081/v1/'
p)LND_DIR = os.getenv('LND_DIR', os.getenv('HOME')+'/.lnd2')
p)cert_path =  LND_DIR+'/tls.cert'
p)macaroon = codecs.encode(open(LND_DIR+'/data/chain/bitcoin/mainnet/admin.macaroon', 'rb').read(), 'hex')
p)headers = {'Grpc-Metadata-macaroon': macaroon}

p)def setURL(new_url):
  global url
  url = new_url
  return url

p)def setTLS(new_cert_path):
  global cert_path
  cert_path = new_cert_path
  return cert_path

p)def setMACAROON(new_macr_path):
  global macaroon
  macaroon = codecs.encode(open(new_macr_path, 'rb').read(), 'hex')
  global headers 
  headers = {'Grpc-Metadata-macaroon': macaroon}
  return headers

p)def getInfo(): 
  endpoint  = 'getinfo'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def bakeMacaroon(data):
  endpoint = 'macaroon'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def exportAllChannelBackups():
  endpoint = 'channels/backup'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def restoreChannelBackups(queryParameters=''):
  endpoint = 'channels/backup/restore'+queryParameters
  r = requests.post(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def verifyChanBackup(queryParameters=''):
  endpoint = 'channels/backup/verify'+queryParameters
  r = requests.post(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def decodeTxid(funding_txid):
  return base64.b64decode(funding_txid)[::-1].hex()

p)def forwardingHistory(data): 
  endpoint  = 'switch'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def listPeers(): 
  endpoint  = 'peers'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def newaddress(queryParameters=''): 
  endpoint  = 'newaddress'+queryParameters
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def walletBalance(): 
  endpoint  = 'balance/blockchain'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def channelBalance(): 
  endpoint  = 'balance/channels'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def listChannels(queryParameters=''):
  endpoint = 'channels'+queryParameters
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def getNetworkInfo():
  endpoint = 'graph/info'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def describeGraph(queryParameters=''):
  endpoint = 'graph'+queryParameters
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def getNodeInfo(pub_key):
  endpoint = 'graph/node/'+pub_key
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def closedChannels(queryParameters=''):
  endpoint = 'channels/closed'+queryParameters
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def closeChannel(funding_txid_str,output_index):
  endpoint = 'channels/'+funding_txid_str+'/'+output_index
  items = []
  r = requests.delete(url+endpoint, headers=headers, verify=cert_path, stream=True)
  for raw_response in r.iter_lines():
    items.append(json.loads(raw_response))
  return items

p)def connectPeer(data): 
  endpoint  = 'peers'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def disconnectPeer(pub_key): 
  endpoint  = 'peers/'+pub_key
  r = requests.delete(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def signmessage(msg): 
  endpoint = 'signmessage'
  msgEncoded = msg.encode()
  data = { 'msg': base64.b64encode(msgEncoded).decode() }
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def unlockWallet(data): 
  endpoint = 'unlockwallet'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def verifymessage(msg,signature): 
  endpoint = 'verifymessage'
  msgEncoded = msg.encode()
  data = { 'signature': signature, 'msg': base64.b64encode(msgEncoded).decode() }
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def addInvoice(data):
  endpoint = 'invoices'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def changePassword(data):
  endpoint = 'changepassword'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def listInvoices(queryParameters=''):
  endpoint = 'invoices'+queryParameters
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def lookupInvoice(r_hash_str):
  endpoint = 'invoice/'+r_hash_str
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def pendingChannels():
  endpoint = 'channels/pending'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def listPayments():
  endpoint = 'payments'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def deleteAllPayments():
  endpoint = 'payments'
  r = requests.delete(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def abandonChannel():
  endpoint = 'channels/abandon/'+funding_txid_str+'/'+output_index
  r = requests.delete(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def genSeed(queryParameters=''):
  endpoint = 'genseed'+queryParameters
  r = requests.delete(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def openChannel(data):
  endpoint = 'channels'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def sendPayment(data):
  endpoint = 'channels/transactions'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def sendCoins(data):
  endpoint = 'transactions'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def estimateFee(queryParameters=''):
  endpoint = 'transactions/fee'+queryParameters
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def sendToRoute(inputs):
  endpoint = 'channels/transactions/route'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=inputs)
  return r.json()

p)def getTransactions():
  endpoint = 'transactions'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def decodePayReq(payment_request): 
  endpoint  = 'payreq/'+payment_request
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def updateChannelPolicy(data):
  endpoint = 'chanpolicy'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def initWallet(data):
  endpoint = 'initwallet'
  r = requests.post(url+endpoint, headers=headers, verify=cert_path, data=json.dumps(data))
  return r.json()

p)def getChanInfo(chan_id):
  endpoint = 'graph/edge/'+chan_id
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def queryRoutes(pub_key,amt,queryParameters=''):
  endpoint = 'graph/routes/'+pub_key+'/'+amt+queryParameters
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def feeReport():
  endpoint = 'fees'
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def listUnspent(queryParameters=''):
  endpoint = 'utxos'+queryParameters
  r = requests.get(url+endpoint, headers=headers, verify=cert_path)
  return r.json()

p)def decoder(Str):
  return base64.b64decode(Str.encode()).decode('ascii')

p)def encoder(Str):
 return base64.b64encode(Str.encode()).decode()

q).lnd.encoder:.p.get[`encoder;<]
q).lnd.decoder:.p.get[`decoder;<]
q).lnd.decodeTxid:.p.get[`decodeTxid;<]
q).lnd.setURL:.p.get[`setURL;<]
q).lnd.setTLS:.p.get[`setTLS;<]
q).lnd.setMACAROON:.p.get[`setMACAROON;<]
q).lnd.initWallet:.p.get[`initWallet;<]
q).lnd.lookupInvoice:.p.get[`lookupInvoice;<]
q).lnd.getNodeInfo:.p.get[`getNodeInfo;<]
q).lnd.genSeed:.p.get[`genSeed;<]
q).lnd.abandonChannel:.p.get[`abandonChannel;<]
q).lnd.changePassword:.p.get[`changePassword;<]
q).lnd.getChanInfo:.p.get[`getChanInfo;<]
q).lnd.queryRoutes:.p.get[`queryRoutes;<]
q).lnd.bakeMacaroon:.p.get[`bakeMacaroon;<]
q).lnd.closedChannels:.p.get[`closedChannels;<]
q).lnd.closeChannel:.p.get[`closeChannel;<]
q).lnd.getNetworkInfo:.p.get[`getNetworkInfo;<]
q).lnd.pendingChannels:.p.get[`pendingChannels;<]
q).lnd.getTransactions:.p.get[`getTransactions;<]
q).lnd.feeReport:.p.get[`feeReport;<]
q).lnd.listUnspent:.p.get[`listUnspent;<]
q).lnd.getInfo:.p.get[`getInfo;<]
q).lnd.exportAllChannelBackups:.p.get[`exportAllChannelBackups;<]
q).lnd.restoreChannelBackups:.p.get[`restoreChannelBackups;<]
q).lnd.verifyChanBackup:.p.get[`verifyChanBackup;<]
q).lnd.updateChannelPolicy:.p.get[`updateChannelPolicy;<]
q).lnd.signmessage:.p.get[`signmessage;<]
q).lnd.addInvoice:.p.get[`addInvoice;<]
q).lnd.listPeers:.p.get[`listPeers;<]
q).lnd.listInvoices:.p.get[`listInvoices;<]
q).lnd.listPayments:.p.get[`listPayments;<]
q).lnd.estimateFee:.p.get[`estimateFee;<]
q).lnd.deleteAllPayments:.p.get[`deleteAllPayments;<]
q).lnd.newaddress:.p.get[`newaddress;<]
q).lnd.walletBalance:.p.get[`walletBalance;<]
q).lnd.channelBalance:.p.get[`channelBalance;<]
q).lnd.connectPeer:.p.get[`connectPeer;<]
q).lnd.disconnectPeer:.p.get[`disconnectPeer;<]
q).lnd.openChannel:.p.get[`openChannel;<]
q).lnd.sendPayment:.p.get[`sendPayment;<]
q).lnd.decodePayReq:.p.get[`decodePayReq;<]
q).lnd.verifymessage:.p.get[`verifymessage;<]
q).lnd.listChannels:.p.get[`listChannels;<]
q).lnd.sendToRoute:.p.get[`sendToRoute;<]
q).lnd.sendCoins:.p.get[`sendCoins;<]
q).lnd.forwardingHistory:.p.get[`forwardingHistory;<]
q).lnd.unlockWallet:.p.get[`unlockWallet;<]
q).lnd.describeGraph:.p.get[`describeGraph;<]
