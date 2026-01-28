-- Asset inventory for enrichment
CREATE TABLE IF NOT EXISTS assets (
  device_id         TEXT PRIMARY KEY,
  host_name         TEXT,
  owner_team        TEXT,
  environment       TEXT,      -- prod/dev/lab
  criticality       TEXT,      -- low/medium/high
  internet_exposed  BOOLEAN,
  tags              TEXT       -- JSON/text list
);
