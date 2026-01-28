-- DNS resolver logs
CREATE TABLE IF NOT EXISTS dns_logs (
  event_time        TIMESTAMP NOT NULL,
  device_id         TEXT,
  host_name         TEXT,
  user_name         TEXT,
  src_ip            TEXT,
  query_name        TEXT NOT NULL,
  query_type        TEXT,       -- A, AAAA, TXT, SRV, etc.
  response_code     TEXT,       -- NOERROR, NXDOMAIN
  answers           TEXT,       -- store JSON/text; warehouse-specific
  resolver_ip       TEXT
);

CREATE INDEX IF NOT EXISTS idx_dns_time ON dns_logs(event_time);
CREATE INDEX IF NOT EXISTS idx_dns_q    ON dns_logs(query_name);
