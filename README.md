# Windows Network Fixer v1.9.1
Fixes Windows network issues.

> [!WARNING]
> ## DUE TO MICROSOFT'S COPYRIGHT LIMITATIONS, THIS BATCH FILE NEED TO BE MODIFIED BEFORE IT CAN BE USED! YOU MUST FOLLOW MICROSOFT'S TERMS OF USE!
> ### Follow these steps in order.
> **1.** Get the necessary modifications from a unmodified `"%windir%\System32\drivers\etc\hosts"` file that is from the same major Windows version as the PC you are tying to fix.  
> **2.** Copy the file line by line into lines 206-226. Skip both the blank line in the `"%windir%\System32\drivers\etc\hosts"` file and line 223. Put the code in between the `(echo ` and `)`.  
> **3**  For line 223 put a `.` in between the `(echo` and `)`.  
> **4.** Put a `^` before every `(` and `)` that is in the code you put in. There is a total of 4 `^` that needs to be put in. Ignore any `(` and `)` that are in the batch file but was not copied by you even if it is in the same line as the code that you put in.

## Network View
- View current network configuration.  
- View DNS servers.  
- View DNS cache.  
- View Winsock catalog.  
- View ARP cache.  
- View routing table.  
- View Hosts file.  
- View Windows Defender Firewall with Advanced Security.  
- View Destination Cache.  
- View current WinHTTP proxy status.

## Network Repairs
- Release and renew IP address(es).  
- Clear DNS cache.  
- Reset Winsock catalog.  
- Reset IPv4 TCP/IP stack.
- Reset IPv6 TCP/IP stack.
- Reset IPv4 and IPv6 TCP/IP stack.
- Clear ARP cache.  
- Clear routing table.  
- Reset Hosts file to default.  
- Set WinHTTP proxy to default.

## Firewall Repairs
- Set Windows Defender Firewall rules to defualt.
