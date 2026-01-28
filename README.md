# Security SQL Analytics (SOC / Detection Engineering)

A practical, portfolio-ready collection of **SQL detections**, **threat hunting queries**, and **audit analytics** built around realistic security telemetry (Windows auth, EDR process events, DNS, proxy, and cloud audit logs).

This repo is designed to demonstrate:
- Detection engineering thinking (signal > noise, context enrichment, tunable thresholds)
- Threat hunting workflows (pivoting across identities, hosts, and network indicators)
- Audit & compliance analytics (access reviews, privilege changes, anomalous admin behavior)

---

## Contents

- `schemas/` — realistic security log schemas + sample fields
- `detections/` — detection queries mapped to common ATT&CK techniques
- `hunting/` — exploratory hunts and pivot patterns
- `audit/` — compliance and security audit analytics
- `enrichment/` — helper tables (asset inventory, identity directory, known-good allowlists)
- `utils/` — reusable SQL snippets (time bucketing, IP parsing, join patterns)

---

## Data Model (Tables)

This repo assumes normalized tables you’d commonly build in a data warehouse:

- `auth_events` — Windows/Linux/IdP authentication outcomes
- `process_events` — EDR process start telemetry
- `dns_logs` — resolver logs / DNS queries
- `proxy_logs` — web proxy / secure web gateway
- `cloud_audit` — cloud control plane events (AWS CloudTrail / Azure / GCP)
- `assets` — inventory + criticality tags
- `identities` — users + departments + role metadata
- `allowlists` — known-good patterns for tuning

See `schemas/` for definitions.

---

## How to Use

1. Create tables based on `schemas/*.sql` (Postgres/Snowflake syntax) or adapt to your warehouse.
2. Load your logs (or map your existing schema to these fields).
3. Start with:
   - `detections/` for alertable queries (high confidence)
   - `hunting/` for investigation pivots (broad and flexible)
   - `audit/` for monitoring admin/control-plane risk

---

## Query Conventions

- All queries are written to be **readable and tunable**.
- Each detection includes:
  - **Goal**
  - **Assumptions**
  - **Tuning knobs** (thresholds, allowlists)
  - **Expected false positives**
  - **Recommended enrichment** (join with `assets`, `identities`)

---

## Detection Engineering Notes

Good detections:
- minimize false positives via context (asset criticality, service accounts, known admin tools)
- are resilient to evasion (behavioral patterns over brittle strings)
- include pivots (username → host → process → network)

---

## MITRE ATT&CK Coverage (examples)

- Credential Access: password spraying, suspicious logon patterns
- Defense Evasion: suspicious PowerShell, LOLBins
- Discovery / Lateral Movement: remote exec patterns, unusual admin activity
- Exfiltration: rare domains, high-volume egress (proxy)

---

## Quick Start: High-Signal Examples

- Password spraying:
  - `detections/auth_password_spray.sql`
- Suspicious PowerShell:
  - `detections/edr_suspicious_powershell.sql`
- Rare DNS domains per host:
  - `hunting/dns_rare_domains_by_host.sql`
- New admin grants in cloud:
  - `audit/cloud_new_admin_grants.sql`

---

## License

MIT — use freely with attribution.
