\d .u

pendingInvoices:([] 
  handle:`int$();
  request:();
  index:`long$();
  settled:`boolean$()
 );

init:{w::t!(count t::tables`.)#()}

del:{w[x]_:w[x;;0]?y};.z.pc:{del[;x]each t};

sel:{$[`~y;x;select from x where sym in y]}

pub:{[t;x]{[t;x;w]if[count x:sel[x]w 1;(neg first w)(`upd;t;x)]}[t;x]each w t}


addPayes:{[handle;tableName;symList]
  $[(count w tableName)>i:w[tableName;;0]?handle;
    .[`.u.w;(tableName;i;1);union;symList];
    w[tableName],:enlist(handle;symList)
  ];
 }

add:{[tableName;symList]
  memo:"Invoice:",.Q.s (!). enlist@'r:(tableName;symList);
  invoice:.lnd.addInvoice[`memo`value`expiry!(memo;100*count symList;3600)];
  insert[`.u.pendingInvoices;enlist@'(.z.w;r;"J"$invoice[`add_index];0b)];
  (tableName;$[99=type v:value tableName;sel[v]symList;0#v];invoice)
 }

sub:{[tableName;symList]
  if[tableName~`;
    :sub[;symList] each t
  ];

  if[not tableName in t;
   'tableName
  ];

  del[tableName].z.w;
  delete from `.u.pendingInvoices where handle in .z.w;
  add[tableName;symList]
 }

end:{(neg union/[w[;;0]])@\:(`.u.end;x)}

processInvoices:{[x]
  msg:first .j.k x;
  if[`state in key msg;
    settledIndex:"J"$msg[`add_index];
    settled:select from .u.pendingInvoices where index=settledIndex;
    .u.addPayes[;;]'[settled`handle;(settled`request)[;0];(settled`request)[;1]];
    delete from `.u.pendingInvoices where index in settledIndex
  ];
 }
