# qlnd

This is a q library (see [kdb+](https://code.kx.com/q/)) which enables communication with a Lightning Labs [`lnd`](https://github.com/lightningnetwork/lnd) node, via the [REST API interface](https://api.lightning.community/rest/index.html?python#lnd-rest-api-reference).

## Functionality

The library supports the majority of APIs enabling users to

* Connect to peers on the network
* Open channels
* Create invoices
* Send payments
* Close channels
* Set fees

## Prerequisites

* kdb+ v3.5 or higher
* Python ≥ 3.5.0 (macOS/Linux) ≥ 3.6.0 windows
* [embedPy](https://github.com/KxSystems/embedPy)
* A bitcoin full node for lnd to communicate with. 
  For install instructions see [Running a Full Node]( https://bitcoin.org/en/full-node).
* A running `lnd` node, for install instructions see [lndGuide](https://github.com/lightningnetwork/lnd/blob/master/docs/INSTALL.md)

## Installing

If you are using GIT, then execute the following clone command in the directory you want the
code to reside 
```C++   
   git clone git@github.com:jlucid/qlnd.git repository
```

The library can then be loaded directly into a q session either on startup, using the command below, 

```C++
    $q qlnd.q
```

Or by using the \l command while within a session

```C++
    q)\l /my/path/to/qlnd.q
```

You can confirm the library was loaded correctly by typing .lnd

```C++
    q).lnd
                   | ::
    encoder        | code.[code[foreign]]`.p.q2pargsenlist
    decoder        | code.[code[foreign]]`.p.q2pargsenlist   
```

## Configure

Currently, in order to make HTTP requests to an `lnd` instance, a TLS/SSL connection and a macaroon are required for RPC authentication. Both the TLS certificate and macaroon tokens are created by the node on startup, and qlnd sets the path to their default locations on startup, which is usually relative to ~/.lnd. However, the location of the certificate and macaroon
can be changed using`.lnd.setTLS` and `.lnd.setMACAROON` functions, respectively.
The hostname and listening port of the `lnd` instance can also be changed easily using `.lnd.setURL`.

```C++
    $q qlnd.p
    q)LND_DIR:getenv[`LND_DIR]
    q).lnd.setURL "https://localhost:8080/v1"
    q).lnd.setTLS LND_DIR,"/tls.cert"
    q).lnd.setMACAROON LND_DIR,”/data/chain/bitcoin/mainnet/admin.macaroon"
```

### Optional Parameters

In the [REST API documentation](https://api.lightning.community/rest/index.html?python#lnd-rest-api-reference), it can be seen that some `GET` requests support optional parameters. For example, [ListInvoices](https://api.lightning.community/rest/index.html#v1-invoices) and [ListUnspent](https://api.lightning.community/rest/index.html#v1-utxos).
These optional Paramters can be added using standard REST notation, as shown below.

```C++
    q).lnd.listUnspent[]  // No optional parameters

    q).lnd.listUnspend["?min_confs=6"]  // Request utxos with a minimum of 6 confirmations
```


## Contact

Jeremy Lucid  
jlucid@kx.com  
https://github.com/jlucid  

