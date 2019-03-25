p)import base64, codecs, json, requests, os
p)from qpython import qconnection
p)url = 'https://localhost:8080/v1/'
p)LND_DIR = os.getenv('LND_DIR', os.getenv('HOME')+'/.lnd')
p)cert_path =  LND_DIR+'/tls.cert'
p)macaroon = codecs.encode(open(LND_DIR+'/data/chain/bitcoin/mainnet/invoice.macaroon', 'rb').read(), 'hex')
p)headers = {'Grpc-Metadata-macaroon': macaroon}

p)q = qconnection.QConnection(host='localhost', port=5010)
p)q.open()

p)def listener(queryParameters=''):
  endpoint  = 'invoices/subscribe'+queryParameters
  r = requests.get(url+endpoint, headers=headers, verify=cert_path, stream=True)
  for raw_response in r.iter_lines():
      json_response = json.loads(raw_response)
      print("Invoice message event received")
      print(raw_response)
      q('.u.processInvoices', raw_response)

q).lnd.listener:.p.get[`listener;<]
q).lnd.listener[]
