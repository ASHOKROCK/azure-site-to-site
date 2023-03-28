# Azure-site-to-site
## Scope
Implement mulit-site S2S vpn.
## Network
![diagram](/pics/NetworkDesign.png)
## Prerequsites
- [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [azure cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) & [sign in](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli)

This repo contains two spoke Vnets (simulated on-prem network) with respective parameters.
- spoke1 ([spoke1-Vnet.azcli](./On-prem/spoke1-Vnet.azcli))
- spoke2 ([spoke1-Vnet.azcli](./On-prem/spoke1-Vnet.azcli))

## Implementation

### Create (on-prem) spokes

1. Create two spoke Vnets. execute below commands in terminal:
   -  ./spoke1-Vnet.azcli
   -  ./spoke2-Vnet.azcli

2. Navigate to your Virtual Machines for public ip's.
3. Copy VM's (acts as network virtual appliance) public ip, required for VPN setup in later section.
### Create Azure Vnet
1. Clone [this](https://github.com/sree7k7/azure-site-to-site) repo and change below parameters. 
> **Note**: Change the *spoke1_Vm_pip* and *spoke2_Vm_pip* (use vm ips copied from above steps)
```azcli
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
2. execute below cmds: (Goto dir: /site-to-site-terrafrom)
  
```terraform
  terraform init
  terraform apply
```


> **Note**: If fails, try to execute: **terraform init -upgrade** on terminal and execute cmd: **terraform apply**

## OnPrem side (i,e simulated local network)

- Goto (login) on-prem VM (local Server i,e windows server).
  - username: `demousr`
  - password: `Password@123`
  
- In VM → Goto Server Manager Dashboard.
→ On top right corner drop down **Manage**. click: Add roles → Installation Type: Role - based or feature - based installation → click: Next → Remote Access → click: next → next → tick: DirectAccess and VPN (RAS), Routing → Install.

- After installating the Roles → click on Flag (On top right corner) → Open the Getting Started Wizard → Choose: Deploy VPN only.

![](/pics/Routing-and-Remote-Access.png)

→ Configure and Enable Routing and Remote Access
→ next → Choose: Custom configuration → select: Demand-dial connections (used for branch office routing), LAN routing, VPN access.
![](/pics/Demand-dial-connections.png)

Finish → start service.

→ click: computerName as shown in below pic.
![](/pics/Demand-dail-Interface.png)


→ add: New Demand-dial interface
→ Interface name: Azure → connection Type: Connect using virtual private networking (VPN) → VPN Type: IKEv2 → Destination Address: public ip (Virtual Network Gateway Public IP address) shown in below pic.

![](/pics/AzureInterface.png)

![](/pics/DestinationAddress.png)

→ In Protocols and Security: Route IP packets on this interface → Next → Static Routes for Remote Networks → click: add → Destination: 10.0.0.0/16 (i,e cloud Vnet cidr), Network Mask: 255.255.0.0 → Metric: 16.
![](/pics/StaticRouteForRemoteNetworks.png)


→Dail-Out Credentials (Optional) → Finish
→ Select: Azure Network Interface → Go to properties → click security → choose: Use preshared key for authentication → type: keyname (e.g: abc@143 (this key is from connections in Virtual Network Gateway))
> **Note**: In this terraform code Preshared Key is: abc@143

![](/pics/AzureProperties.png)

![](/pics/connect.png)

→ Check the status in Azure: Connections under Virtual Network Gateway
Goto → Virtuanl Network Gateway (VPN Gateway) → On left side click: **connections**.

![](/pics/VPNGW-connection.png)

The update will take sometime.
- Connect VM, open browser enter destination VM private ip in url to see Microsoft default page over S2S.

Links: 
- [https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-create-gateway-portal](https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-create-gateway-portal)


- [https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-site-to-site-portal](https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-site-to-site-portal)