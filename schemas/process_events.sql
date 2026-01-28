-- EDR process creation telemetry
CREATE TABLE IF NOT EXISTS process_events (
  event_time        TIMESTAMP NOT NULL,
  device_id         TEXT,
  host_name         TEXT,
  user_name         TEXT,
  process_name      TEXT,
  process_path      TEXT,
  process_cmdline   TEXT,
  parent_name       TEXT,
  parent_path       TEXT,
  parent_cmdline    TEXT,
  process_sha256    TEXT,
  signed            BOOLEAN,
  signer            TEXT,
  integrity_level   TEXT,     -- "Low" "Medium" "High" "System"
  pid               BIGINT,
  ppid              BIGINT
);

CREATE INDEX IF NOT EXISTS idx_proc_time ON process_events(event_time);
CREATE INDEX IF NOT EXISTS idx_proc_host ON process_events(host_name);
CREATE INDEX IF NOT EXISTS idx_proc_user ON process_events(user_name);
