# Windows Network Fixer v1.8.6
Fixes Windows network issues.

> [!WARNING]
> ## DUE TO MICROSOFT'S COPYRIGHT LIMITATIONS, THIS BATCH FILE NEED TO BE MODIFIED BEFORE IT CAN BE USED! YOU MUST FOLLOW MICROSOFT'S TERMS OF USE ON THEIR CODE!
> ### Follow these steps in order.
> **1.** Get the necessary modifications from here https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/deployment/windows-to-go/deploy-windows-to-go.  
> **2.** Scroll to the first "san_policy.xml" file and copy it line by line into lines 804-841 but skip lines 829-839. Put the code in between the `(echo ` and `)`. Remember to include all spaces!  
> **3.** In lines 829-839 copy what you have put in for 818-828 but on line 834 change `amd64` to `arm64`.  
> **4.** Put a `^` before every `<` and `>` that is in the code you put in. There is a total of 34 `^` that needs to be put in. Ignore any `<` and `>` that are in the batch file but was not copied by you even if it is in the same line as the code that you put in.

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
- Reset TCP/IP stack.  
- Clear ARP cache.  
- Clear routing table.  
- Reset Hosts file to default.  
- Set WinHTTP proxy to default.

## Firewall Repairs
- Set Windows Defender Firewall rules to defualt.
