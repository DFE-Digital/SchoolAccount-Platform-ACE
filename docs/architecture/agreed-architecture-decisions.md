# School Account ACE Architecture - Agreed Architecture Decisions

## Azure Container Apps Environments

A dedicated Azure Container Apps Environment (ACE) will be provisioned for each School Account environment:

- Dev
- PreProd
- Production

This provides:

- Environment separation
- Independent configuration
- Reduced deployment risk

---

## Private Ingress Azure Container Apps Environment

School Account will utilise **Private Azure Container Apps Environments**.

- ACE ingress will not be publicly exposed.
- Environment ingress will be private by design.
- Azure Internal Load Balancers will be used within each Azure Container Apps Environment.

### Traffic Flow

#### Production Traffic Flow

```text
Internet
    │
Barracuda WAF
    │
DfE Internal Network
    │
Production Azure Container Apps Environment
```

All production traffic will enter via the approved Barracuda WAF before traversing the DfE internal network to the Production ACE.

#### Dev and PreProd Traffic Flow

```text
DfE Internal Users
    │
DfE Internal Network
    │
Dev / PreProd Azure Container Apps Environment
```

- No Barracuda WAF is required.
- Access will be restricted to users connected to the DfE network.

---

## DfE ServiceNow Requests

Implementation of the chosen architecture is expected to require engagement with DfE infrastructure and networking teams through ServiceNow requests.

Potential request areas include:

- Connectivity between DfE internal networks and Azure Container Apps environments
- DNS configuration and management
- Firewall and access rule configuration
- WAF onboarding and configuration (new onboarding to UK South WAF)

---

## DNS Considerations

As a private ACE architecture has been selected, internal DNS resolution will be required to allow DfE users and services to resolve Azure Container Apps endpoints.

Potential requirements include:

- Internal resolution of ACA environment endpoints
- Internal resolution of deployment label endpoints
- DNS forwarding and conditional forwarding rules
- Public DNS records for user-facing endpoints
- Custom domain management and certificate provisioning

---

## Future Deployment Considerations

The agreed Azure Container Apps architecture is independent of the deployment approach adopted by School Account. However, a future decision is required regarding how application deployments will be managed across environments.

Azure Container Apps supports both **Multiple Revisions** and **Deployment Labels**, each providing different release management capabilities.

Potential benefits of Deployment Labels include:

- Stable endpoints for release validation
- Blue/Green deployment workflows
- Candidate release testing within the Production ACE
- Deployment workflows similar to App Service staging slots

Future design activities should determine:

- Whether Deployment Labels will be adopted
- Whether a consistent deployment approach should be used across environments
- The endpoint strategy for candidate and validation releases
- Whether custom domains are required for Deployment Label endpoints
- Any associated DNS and certificate management requirements

The adoption of Deployment Labels can be assessed independently of the agreed Azure Container Apps Environment architecture.

---

## Summary

The agreed architecture is based on:

- One ACE per environment
- Private ACE environment
- Production traffic routed through the Production WAF
- Dev and PreProd accessible from the DfE internal network only
- Internal DNS and networking changes to support private connectivity
- DfE infrastructure engagement required to implement networking, DNS and WAF integration

---

## Out of Scope

This investigation focused on:

- Azure Container Apps Environment design
- Ingress architecture
- Endpoint strategy
- Deployment patterns

The design and implementation of private connectivity to dependent Azure services (for example Key Vault, Azure SQL Database and Storage Accounts) should be addressed during infrastructure implementation and operational readiness activities.
