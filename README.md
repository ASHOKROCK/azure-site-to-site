# Azure-site-to-site
## Scope
Implement mulit-site S2S vpn.
# Network diagram
![diagram](/pics/NetworkDesign.png)
## Prerequsites
- [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [azure cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) & [sign in](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli)

This repo contains two spoke accounts (simulated on-prem network) with respective parameters.
- spoke1 ([spoke1-Vnet.azcli](./On-prem/spoke1-Vnet.azcli))
- spoke2 ([spoke1-Vnet.azcli](./On-prem/spoke1-Vnet.azcli))


1. Create the spoke Vnets. Copy and paste below commands in termianl:
   -  ./spoke1-Vnet.azcli
   -  ./spoke2-Vnet.azcli

2. Navigate to your Virtual Machines for public ip's.
3. Copy these VM (acts as network virtual appliance) public ip's, required for VPN setup in later section.
4. Clone this repo and change below parameters  or keep default. **Note**: Change the *spoke1_Vm_pip* and *spoke2_Vm_pip* (use vm ips copied from above steps)
```
  resource_group_location = "northeurope"
  vnet_cidr = "10.6.0.0/16"
  public_subnet_address = "10.6.1.0/24"
  private_subnet_address = "10.6.2.0/24"
  gateway_subnet_address = "10.6.3.0/24"
  # Simulated on-prem details
  spoke1cidr = "10.1.0.0/16" 
  spoke2cidr = "10.2.0.0/16"
  spoke1_Vm_pip = "87.49.45.xxx" 
  spoke2_Vm_pip = "87.49.45.xx"
```
1. execute below cmds: (Goto dir: /site-to-site-terrafrom)
   - terraform init
   - terraform plan
   - terraform apply



**Note**: If fails, try to execute: *terraform init -upgrade* on terminal and execute cmd: *terraform apply --auto-approve*

# OnPrem side (i,e simulated local network)
Goto (rdp login) on-prem (Local Server e.g: windows server 2022)
- username: demousr
- password: Password@123
  
-> Goto Server Manager Dashboard.
-> Drop down **Manage** on top right corner. click: Add roles-> Installation Type: Role-based or feature-based installation -> click: Next -> Remote Access -> click: next -> next -> tick: DirectAccess and VPN (RAS), Routing -> Install

After installation the Roles -> click on Flag (On top right corner) -> Open the Getting Started Wizard -> Choose: Deploy VPN only

![](/pics/Routing-and-Remote-Access.png)

-> Configure and Enable Routing and Remote Access
-> next -> Choose: Custom configuration -> select: Demand-dial connections (used for branch office routing), LAN routing, VPN access.
![](/pics/Demand-dial-connections.png)

Finish -> start service

-> click: computerName as shown in below pic.
![](/pics/Demand-dail-Interface.png)


-> add: New Demand-dial interface
-> Interface name: Azure -> connection Type: Connect using virtual private networking (VPN) -> VPN Type: IKEv2 -> Destination Address: public ip (Virtual Network Gateway Public IP address) shown in below pic.

![](/pics/AzureInterface.png)

![](/pics/DestinationAddress.png)

-> In Protocols and Security: Route IP packets on this interface -> Next -> Static Routes for Remote Networks -> click: add -> Destination: 10.0.0.0/16 (i,e cloud Vnet cidr), Network Mask: 255.255.0.0 -> Metric: 16
![](/pics/StaticRouteForRemoteNetworks.png)


->Dail-Out Credentials (Optional) -> Finish
-> Select: Azure Network Interface -> Go to properties -> click security -> choose: Use preshared key for authentication -> type: keyname (e.g: abc@143 (this key is from connections in Virtual Network Gateway))
Note: In the above code Preshared Key is: abc@143

![](/pics/AzureProperties.png)

![](/pics/connect.png)

-> Check the status in Azure: Connections under Virtual Network Gateway
Goto -> Virtuanl Network Gateway (VPN Gateway) -> On left side click: connections.

![](/pics/VPNGW-connection.png)

The update will take sometime.
- Open browser enter destination VM private ip over S2S.

Links: 
- [https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-create-gateway-portal](https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-create-gateway-portal)


- [https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-site-to-site-portal](https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-site-to-site-portal)