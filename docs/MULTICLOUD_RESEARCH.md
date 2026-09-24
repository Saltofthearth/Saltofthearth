# 🌐 Zero-Cost Multicloud Infrastructure & API Specification

> **A Comprehensive Specification for Sovereign, Zero-Cost Cloud Architecture using Always-Free Tiers, Platform Credits, and Optimal Quota Refresh Scheduling.**

---

## 🏛️ 1. Architectural Strategy & Philosophy

Achieving zero-cost multicloud infrastructure requires treating cloud providers not as monolithic destinations, but as **ephemeral, commodity compute/storage tiers**. By mapping workload components (Edge, Compute, Database, AI/Inference, Storage, CI/CD) to providers offering **Always-Free (indefinite)** quotas, we eliminate cloud expenditure while building highly resilient, fault-tolerant architectures.

### Key Operational Principles
1. **Zero-Dollar Budget Enforcers**: Use provider-native budget alerts, hard billing limits, and zero-dollar spending limits to prevent accidental charges.
2. **Stateless Compute & Decoupled Storage**: Deploy stateless workloads on serverless/edge containers while keeping persistent state in replicated free-tier managed databases (Postgres, DynamoDB, Cloudflare D1/R2).
3. **Automated Quota Refresh Rotation**: Route requests and execute batch workloads based on daily, weekly, and monthly quota reset schedules.
4. **OpSec & Credential Hygiene**: Isolate provider credentials using environment secrets, GPG/SOPS, and automated key rotation.

---

## ☁️ 2. Major Cloud Infrastructure Providers (IaaS / PaaS)

### 2.1 Oracle Cloud Infrastructure (OCI) — *The Compute Powerhouse*
OCI offers the most generous always-free compute and block storage allocations across all public cloud providers.

| Resource | Always-Free Allowance | Key Limits & Constraints | Quota Reset Cadence |
| :--- | :--- | :--- | :--- |
| **Ampere ARM Compute** | 4 OCPUs (vCPUs), 24 GB RAM | Can be split into up to 4 VMs (e.g., 1 x 4 OCPU / 24GB or 4 x 1 OCPU / 6GB) | Indefinite continuous |
| **AMD x86 Compute** | 2 VMs (`VM.Standard.E2.1.Micro`), 1 GB RAM each | 1/8 OCPU per instance | Indefinite continuous |
| **Block Volume Storage** | 200 GB total storage | Shared across boot & block volumes (min 47GB per boot volume) | Continuous |
| **Object Storage** | 10 GB Standard Object Storage | 10 GB Archive Storage, 50k API requests/month | Monthly |
| **Outbound Data Egress** | **10 TB / month** | Applicable across all regions | Monthly calendar |
| **Autonomous Database** | 2 instances (Transaction Processing or Data Warehouse) | 1 OCPU and 20 GB storage per DB instance | Continuous (reclaims if idle 7 days) |
| **Flexible Load Balancer** | 1 instance at 10 Mbps bandwidth | 1 Network Load Balancer | Continuous |

> ⚠️ **Idle Policy Warning**: OCI reclaims ARM instances if CPU utilization falls below 20% over a 7-day period, memory utilization is below 20%, or network bandwidth is below 20%. Keep light background jobs/heartbeats active.

---

### 2.2 Google Cloud Platform (GCP) — *Serverless & Analytics Core*

| Resource | Always-Free Allowance | Key Limits & Constraints | Quota Reset Cadence |
| :--- | :--- | :--- | :--- |
| **Compute Engine** | 1 `e2-micro` VM (0.25 vCPU, 1 GB RAM) | Oregon (`us-west1`), Iowa (`us-central1`), or S. Carolina (`us-east1`). 30 GB standard HDD. | Continuous |
| **Cloud Run** | 2,000,000 requests / month | 360,000 GB-seconds memory, 180,000 vCPU-seconds | Monthly calendar |
| **Cloud Functions** | 2,000,000 invocations / month | 400,000 GB-seconds, 200,000 GHz-seconds compute | Monthly calendar |
| **Firestore Database** | 1 GB storage | 50,000 reads, 20,000 writes, 20,000 deletes / day | **Daily (00:00 UTC)** |
| **BigQuery** | 10 GB storage, 1 TB queries / month | Storage & query analytics | Monthly calendar |
| **Cloud Storage** | 5 GB standard storage | Restricted to US regions (`us-east1`, `us-west1`, `us-central1`) | Continuous |
| **Cloud Build** | 120 build-minutes / day | Container builds and automated steps | **Daily (00:00 UTC)** |
| **Cloud Shell** | 1 full Linux VM with 5 GB persistent home dir | Web/CLI SSH interface, 60 hours usage / week | **Weekly rolling** |
| **Data Egress** | 1 GB egress / month | From North America to all destinations (excl. China/Australia) | Monthly calendar |

---

### 2.3 Amazon Web Services (AWS) — *Edge CDN & Event Queue Layer*

| Resource | Always-Free Allowance | Key Limits & Constraints | Quota Reset Cadence |
| :--- | :--- | :--- | :--- |
| **Amazon CloudFront** | **1 TB data transfer out / month** | 10,000,000 HTTP/HTTPS requests + 2,000,000 CloudFront Function invocations | Monthly calendar |
| **AWS Lambda** | 1,000,000 requests / month | 3.2 million seconds compute time (400,000 GB-seconds) | Monthly calendar |
| **Amazon DynamoDB** | 25 GB storage | 25 WCU (Write Capacity Units) & 25 RCU (Read Capacity Units) | Continuous |
| **Amazon SQS** | 1,000,000 requests / month | Message queueing layer | Monthly calendar |
| **Amazon SNS** | 1,000,000 publish requests / month | 100,000 HTTP/S notifications, 1,000 email notifications | Monthly calendar |
| **Amazon CloudWatch** | 10 custom metrics & 10 alarms | 1,000,000 API requests, 5 GB log data ingestion & 5 GB archive | Monthly calendar |
| **AWS CodeBuild** | 100 build-minutes / month | `build.general1.small` instance type | Monthly calendar |

---

### 2.4 Cloudflare — *Global Edge, DNS, & Object Tier*

| Resource | Always-Free Allowance | Key Limits & Constraints | Quota Reset Cadence |
| :--- | :--- | :--- | :--- |
| **Cloudflare Workers** | 100,000 requests / day | 128 MB RAM per subrequest, 10ms CPU time | **Daily (00:00 UTC)** |
| **Cloudflare Pages** | Unlimited static hosting | 500 builds / month, 100 custom domains | Monthly calendar |
| **Cloudflare R2 (S3-compatible)** | **10 GB storage / month** | **10,000,000 Class A (read) ops, 1,000,000 Class B (write) ops**, **$0 Egress fees** | Monthly calendar |
| **Cloudflare D1 (SQL)** | 5 GB total database storage | 5,000,000 read rows / day, 100,000 write rows / day | **Daily (00:00 UTC)** |
| **Cloudflare Workers KV** | 1 GB storage | 100,000 read requests / day, 1,000 write/delete / day | **Daily (00:00 UTC)** |
| **Cloudflare Vectorize** | 5,000,000 query dimensions / month | Vector database for embeddings | Monthly calendar |
| **Cloudflare Workers AI** | Free daily neuron usage | Inference for Llama 3, Whisper, Embeddings | **Daily (00:00 UTC)** |

---

## 🗄️ 3. Specialized SaaS, Managed Databases & Storage

| Service / Platform | Primary Capability | Always-Free Allowance | Critical Constraints / Notes | Quota Reset |
| :--- | :--- | :--- | :--- | :--- |
| **Supabase** | Managed PostgreSQL + Auth | 2 active projects, 500 MB DB, 1 GB Storage, 50k MAU | Pauses after 7 days of inactivity (resume via API) | Continuous |
| **Neon Tech** | Serverless Postgres | 0.5 GiB storage, 1 project, auto-scaling compute | Auto-suspends compute when idle | Continuous |
| **Upstash** | Serverless Redis & Vector | 10,000 requests / day (Redis), 10,000 requests / day (Vector) | Max 256 MB data storage per DB | **Daily** |
| **Backblaze B2** | Object Storage | 10 GB storage, 1 TB egress via Cloudflare routing | Egress is free when routed through Cloudflare CDN | Continuous / Monthly |
| **Render** | Web Services & Static Sites | 512 MB RAM Web Services (750 hours/mo), static sites unlimited | Free Web Services spin down after 15 min idle | Monthly calendar |
| **Fly.io** | Micro VM Containers | Up to 3 x 256MB micro VMs or equivalent usage allowance | Requires credit card verification | Monthly calendar |
| **Vercel** | Edge Next.js / Frontend | 100 GB bandwidth / month, Serverless Function execution | Non-commercial usage terms | Monthly calendar |
| **Netlify** | Jamstack / Static Hosting | 100 GB bandwidth / month, 300 build minutes / month | Serverless Functions 125k requests / mo | Monthly calendar |

---

## 🤖 4. Generative AI, LLM, & Machine Learning APIs

| Provider / API | Model Availability | Free Tier Allowance | Rate Limits / Quotas | Quota Reset |
| :--- | :--- | :--- | :--- | :--- |
| **Google AI Studio** | Gemini 2.0 Flash, Gemini 1.5 Flash, Gemini 1.5 Pro | **Gemini 2.0 / 1.5 Flash**: 15 RPM, 1,000,000 TPM, 1,500 RPD | **1,500 Requests / Day** | **Daily (00:00 Pacific / UTC)** |
| **Groq Cloud API** | Llama 3.3 70B, Llama 3.1 8B, DeepSeek R1 Distill | ~30 RPM, 14,400 RPD depending on model (e.g., Llama 3.3 70B: 6,000 TPM) | Extremely fast token execution | **Daily / Per Minute** |
| **Hugging Face** | Serverless Inference API & Spaces | Access to thousands of open models; free CPU Spaces (16GB RAM) | Rate limited dynamically per token/IP | Continuous |
| **Cloudflare Workers AI** | Llama 3.1 8B, Whisper, BGE Embeddings | 10,000 Neurons / day | Integrated into Cloudflare Workers pipeline | **Daily (00:00 UTC)** |
| **Kaggle Notebooks** | Jupyter Notebooks (Python/R) | **30 GPU hours / week** (Nvidia T4/P100), 20 TPU hours / week | 30 GB RAM, 4 CPU cores | **Weekly rolling** |
| **Google Colab** | Jupyter Notebooks | T4 GPU acceleration on dynamic availability | Idle timeouts after 12-24 hours | Daily dynamic |

---

## 🐙 5. CI/CD, Container Registries & Source Code Systems

| Service | Category | Free Tier Allocation | Reset Schedule |
| :--- | :--- | :--- | :--- |
| **GitHub** | Code Repositories & CI/CD | Unlimited public repos; **2,000 GitHub Actions build minutes/month** for private repos (unlimited for public repos); 500 MB GitHub Packages storage | Monthly billing cycle |
| **GitLab** | Code Repositories & CI/CD | 400 compute minutes / month for private projects; 10 GB storage limit | Monthly calendar |
| **Docker Hub** | Container Registry | 1 private repository, unlimited public repositories; 200 pull requests per 6 hours (unauthenticated 100/6h) | 6-Hour Window |
| **GitHub Container Registry (GHCR)** | OCI Registry | Unlimited public image storage and bandwidth | Continuous |

---

## 🗓️ 6. Quota Refresh Matrix & Execution Lifecycle

To prevent rate-limit exhaustion or service suspension, workload placement should adhere to this timing matrix:

```
+-----------------------------------------------------------------------------------+
|                            QUOTA REFRESH TIMELINE                                 |
+-----------------------------------------------------------------------------------+
|  DAILY RESET (00:00 UTC)      |  WEEKLY RESET               |  MONTHLY RESET      |
+-------------------------------+-----------------------------+---------------------+
| - Cloudflare Workers (100k)   | - Kaggle GPUs (30 hrs)      | - OCI Egress (10TB) |
| - Cloudflare D1 Reads (5M)    | - Cloud Shell (60 hrs)      | - AWS CloudFront(1TB|
| - GCP Firestore (50k reads)   |                             | - GCP Cloud Run(2M) |
| - GCP Cloud Build (120 mins)  |                             | - AWS Lambda (1M)   |
| - Upstash Redis (10k req)     |                             | - Supabase (Active) |
| - Google AI Studio (1.5k req) |                             | - GitHub Actions    |
| - Groq API (14.4k req)        |                             |   (2,000 min)       |
+-------------------------------+-----------------------------+---------------------+
```

### Rotation Strategy Guidelines:
1. **High-Frequency API Calls**: Primary routing via Cloudflare Workers (100k req/day). When approaching 90% threshold (90k req), failover to GCP Cloud Run (2M req/month).
2. **Database Read Distribution**: Primary queries to Cloudflare D1 (5M row reads/day) and Supabase Postgres. High-speed caching in Upstash Redis (10k req/day).
3. **Large File Storage & Downloads**: Direct client downloads served via Cloudflare R2 (10GB + zero egress fees) or Backblaze B2 proxied through Cloudflare.
4. **Heavy Batch Compute / AI**: Daily LLM processing routed to Google AI Studio Gemini Flash (1.5k req/day) and Groq API. Long-running model fine-tuning offloaded to Kaggle/Colab GPU workflows.

---

## 🛡️ 7. Operational Security (OpSec) & Cost Prevention Guardrails

1. **Zero-Dollar Budget Alarms**:
   - AWS: Configure AWS Budgets with $0.01 threshold -> trigger SNS alert and Lambda function to disable non-essential resources if breached.
   - GCP: Create $0.01 Budget Alert -> Publish to Pub/Sub -> Cloud Function turns off billing on project.
   - OCI: Set up OCI Budget at $1.00 threshold with email/Slack alerting.

2. **Dormancy & Inactivity Mitigation**:
   - Supabase & OCI reclaim inactive databases/VMs. Implement a GitHub Actions workflow running on a daily cron schedule (`0 0 * * *`) that executes a lightweight heartbeat ping against OCI instances and Supabase API endpoints.

3. **Secrets Management**:
   - Store all cloud access keys, API tokens, and database credentials using encrypted GitHub Repository Secrets or local GPG/SOPS encrypted configuration files (`secrets.enc.env`). Never hardcode secrets in `.tf` or `.json` files.
