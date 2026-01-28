-- Normalized authentication events
-- Used by:
--   - Password spray detection
--   - Brute-force hunting
--   - Impossible travel analysis

-- Authentication events (Windows Security, Okta, Azure AD, Linux auth, etc.)
CREATE TABLE IF NOT EXISTS auth_events (
  event_time        TIMESTAMP NOT NULL,
  source            TEXT,                -- e.g., "windows_security", "okta", "aad"
  event_type        TEXT,                -- "logon", "mfa", "session"
  outcome           TEXT NOT NULL,        -- "success" | "failure"
  user_name         TEXT,
  user_id           TEXT,
  user_domain       TEXT,
  src_ip            TEXT,
  src_geo_country   TEXT,
  src_geo_region    TEXT,
  src_asn           TEXT,
  device_id         TEXT,
  host_name         TEXT,
  host_os           TEXT,
  auth_method       TEXT,                -- "password", "sso", "oauth", "ssh_key"
  mfa_used          BOOLEAN,
  failure_reason    TEXT,                -- "bad_password", "user_not_found", "locked"
  logon_type        TEXT,                -- Windows: "Interactive", "Network", "RDP"
  raw_event_id      TEXT                 -- native event id if applicable
);

CREATE INDEX IF NOT EXISTS idx_auth_time ON auth_events(event_time);
CREATE INDEX IF NOT EXISTS idx_auth_user ON auth_events(user_name);
CREATE INDEX IF NOT EXISTS idx_auth_ip   ON auth_events(src_ip);

