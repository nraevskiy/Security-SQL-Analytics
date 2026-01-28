-- Identity directory enrichment
CREATE TABLE IF NOT EXISTS identities (
  user_name         TEXT PRIMARY KEY,
  user_id           TEXT,
  department        TEXT,
  title             TEXT,
  manager           TEXT,
  is_service_account BOOLEAN,
  is_privileged      BOOLEAN,
  status            TEXT        -- active/disabled
);
