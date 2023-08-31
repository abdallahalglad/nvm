FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install RDS role and dependencies
RUN powershell -Command \
    Install-WindowsFeature -Name RDS-RD-Server, RDS-Licensing, RDS-Connection-Broker, RDS-Web-Access -IncludeAllSubFeature -Verbose

# Configure RDP settings
RUN powershell -Command \
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0; \
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Expose necessary ports
EXPOSE 3389

# Start the RDP server
CMD ["cmd.exe", "/C", "start", "cmd.exe", "/K", "C:\\Windows\\System32\\mstsc.exe"]
