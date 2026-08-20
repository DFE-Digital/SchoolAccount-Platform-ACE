# School Account ACE Architecture Design Options

## Objective

Investigate Azure Container Apps architecture options for School Account and identify key decisions, implications and recommendations relating to:

- ACA Environment design (Public vs Private)
- Networking
- Ingress
- Endpoints
- DNS
- Deployment validation

---

## Current Assumptions

### Platform Environments

A dedicated Azure Container Apps Environment (ACE) will exist for each School Account environment:

- Dev Azure Container Apps Environment
- PreProd Azure Container Apps Environment
- Prod Azure Container Apps Environment

Benefits:

- Clear environment separation
- Independent configuration
- Reduced deployment risk
- Simpler operational support

---

## Revision Management (Findings from SAB-157)

Azure Container Apps supports:

- Single Revision
- Multiple Revisions
- Deployment Labels

Both Multiple Revisions and Deployment Labels support:

- Blue/Green deployments
- Canary deployments
- Traffic splitting
- Rollback

The deployment capabilities are very similar. The main difference is the level of abstraction used to route traffic:

- Multiple Revisions route traffic directly to revisions.
- Deployment Labels route traffic through labels and provide stable endpoints.

---

## Endpoint Options

### Multiple Revisions

Application URL:

```text
https://schoolaccount.azurecontainerapps.io
```

Revision URLs:

```text
https://schoolaccount--rev1.azurecontainerapps.io
https://schoolaccount--rev2.azurecontainerapps.io
```

Traffic is routed directly to revisions through a single application endpoint.

### Deployment Labels

```text
https://schoolaccount.azurecontainerapps.io
https://schoolaccount---live.azurecontainerapps.io
https://schoolaccount---candidate.azurecontainerapps.io
```

Provides stable, label-specific endpoints.

Example:

```text
live      -> Production revision
candidate -> Candidate revision
```

This allows production release validation before promotion.

---

## Label Endpoints Using Custom Domains

### Option A - ACA Generated URLs

```text
schoolaccount---candidate.azurecontainerapps.io
```

#### Pros

- No DNS management
- Simple implementation

### Option B - Custom Label Domains

```text
candidate.schoolaccount.education.gov.uk
```

#### Pros

- Easier for testers and support teams
- Cleaner user experience

#### Cons

- Additional DNS management
- Additional certificate management

---

## Architecture Option 1 - Public ACE Environment

### Overview

```text
Internet
    │
Barracuda WAF
    │
Azure Container Apps Environment (Public Endpoint)
```

### Characteristics

- Public-facing frontend IP behind Barracuda WAF
- Container apps can expose external ingress
- No Private Endpoint required
- Simplest architecture

### Advantages

- Simpler architecture
- Fewer networking components
- Easier DNS management
- Faster implementation

### Disadvantages

- Publicly reachable endpoints
- Greater reliance on perimeter security controls
- Less restrictive security posture

---

## Architecture Option 2 - Private ACE Environment

### Overview

```text
Internet
    │
Barracuda WAF
    │
DfE Internal Network
    │
Azure Container Apps Environment
```

### Characteristics

- Built from day one as an internal environment
- No public endpoint
- Uses an Azure Internal Load Balancer
- Environment ingress is private by design

### Advantages

- Reduced public exposure
- Stronger security boundary
- Aligns with private networking principles

### Disadvantages

- Increased complexity
- Private DNS requirements
- Additional networking dependencies
- Increased operational overhead

---

## Architecture Option 3 - Public ACE with Private Endpoints

### Overview

```text
Internet
    │
Barracuda WAF
    │
DfE Internal Network
    │
Private Endpoint
    │
Azure Container Apps Environment
```

### Characteristics

- Environment created as a public ACA Environment
- Public Network Access disabled after creation
- Public ingress blocked
- Access via one or more Private Endpoints
- Private DNS required

### Advantages

- Reduced public exposure
- Access restricted to approved networks via Private Link
- Supports defence-in-depth
- Public Network Access can be enabled or disabled without recreating the environment
- Aligns with common Azure Private Endpoint patterns

### Disadvantages

- More complex than a fully public ACA Environment
- Additional Azure resources required
- Increased operational overhead
- Additional troubleshooting complexity
- Architectural differences from a true Internal ACA Environment require investigation
- Similar complexity to a Private ACA Environment while delivering comparable security outcomes

### Investigation Finding

Testing demonstrated that a Public ACA Environment can have Public Network Access disabled after creation.

In this configuration:

- Azure no longer accepts traffic via the public endpoint
- Traffic is expected through Private Endpoints

Further investigation is required to understand the differences between this model and a true Internal ACA Environment using an Azure Internal Load Balancer.

---

## Key Design Questions

### Networking

- Should ACA be public or private?
- Will all traffic terminate through the Barracuda WAF?
- What existing DfE networking standards apply?

### DNS

- Should deployment label endpoints use Azure-generated URLs or custom domains?
- Will private DNS be required?

### Deployment Validation

- Will Deployment Labels be used for production validation?
- Should candidate endpoints be externally accessible?
- Should candidate endpoints be restricted to DfE networks?

### Platform Direction

- Is simplicity preferred over stricter network isolation?
- Are future microservices or internal ACA-to-ACA communication expected?

---

## Initial Recommendation

A dedicated Azure Container Apps Environment per School Account environment appears appropriate.

Deployment Labels provide a compelling production validation capability similar to App Service staging slots.

The primary architectural decision is whether School Account should use a public or private ACA Environment, balancing:

- Security requirements
- Networking complexity
- DNS requirements
- Operational overhead