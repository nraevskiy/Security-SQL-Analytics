-- Web proxy / SWG logs
CREATE TABLE IF NOT EXISTS proxy_logs (
  event_time        TIMESTAMP NOT NULL,
  user_name         TEXT,
  device_id         TEXT,
  host_name         TEXT,
  src_ip            TEXT,
  url               TEXT,
  domain            TEXT,
  http_method       TEXT,
  http_status       INTEGER,
  bytes_out         BIGINT,
  bytes_in          BIGINT,
  user_agent        TEXT,
  category          TEXT,
  tls_ja3           TEXT
);

CREATE INDEX IF NOT EXISTS idx_proxy_time ON proxy_logs(event_time);
CREATE INDEX IF NOT EXISTS idx_proxy_dom  ON proxy_logs(domain)
