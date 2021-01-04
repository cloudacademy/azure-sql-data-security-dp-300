SELECT * FROM sys.firewall_rules ORDER BY Name
EXECUTE sp_set_firewall_rule @Name = N'Azure Resources', @Start_ip_address = '0.0.0.0', @end_ip_address = '0.0.0.0'
EXECUTE sp_delete_firewall_rule @Name = N'AllowAllWindowsAzureIps'

SELECT * FROM sys.database_firewall_rules ORDER BY Name

EXECUTE sp_set_database_firewall_rule @Name = N'Home', @Start_ip_address = '127.0.0.1', @end_ip_address = '127.0.0.2'
EXECUTE sp_delete_database_firewall_rule