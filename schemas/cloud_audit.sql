-- Cloud control plane logs (CloudTrail/Azure/GCP normalized)
CREATE TABLE IF NOT EXISTS cloud_audit (
  event_time        TIMESTAMP NOT NULL,
  cloud             TEXT,        -- "aws" "azure" "gcp"
  account_id        TEXT,
  region            TEXT,
  actor_type        TEXT,        -- "user" "role" "service_principal"
  actor_name        TEXT,
  actor_id          TEXT,
  src_ip            TEXT,
  user_agent        TEXT,
  service           TEXT,        -- "iam" "ec2" "s3" "azuread" etc.
  action            TEXT,        -- API/action name
  resource_type     TEXT,
  resource_id       TEXT,
  outcome           TEXT,        -- "success" "failure"
  error_code        TEXT,
  request_params    TEXT,        -- JSON/text
  response_elements TEXT         -- JSON/text
);

CREATE INDEX IF NOT EXISTS idx_cloud_time ON cloud_audit(event_time);
CREATE INDEX IF NOT EXISTS idx_cloud_actor ON cloud_audit(actor_name);
