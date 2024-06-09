

:global brname "bridgeLocal"
# wait for interfaces
{
  :local count 0;
  :while ([/interface ethernet find] = "") do={
    :if ($count = 30) do={
      :log warning "DefConf: Unable to find ethernet interfaces";
      /quit;
    }
    :delay 1s; :set count ($count +1); 
  };
}

# create bridge and add all ethernet interfaces
/interface bridge add name=$brname disabled=yes auto-mac=yes;
{
  :local bMACIsSet 0;
  :foreach k in=[/interface find where !(slave=yes || name~$brname)] do={
    :local tmpPortName [/interface get $k name];
    :if ($bMACIsSet = 0) do={
      :if ([/interface get $k type] = "ether") do={
        /interface bridge set $brname auto-mac=no admin-mac=[/interface get $tmpPortName mac-address] disabled=no;
        :set bMACIsSet 1;
      }
    }
    :if (([/interface get $k type] = "ether")) do={
      /interface bridge port add bridge=$brname interface=$tmpPortName;
    }
  }
}

/ip dhcp-client add interface=$brname disabled=no;



