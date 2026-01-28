-- Generic allowlist table for tuning detections (regex/pattern based)
CREATE TABLE IF NOT EXISTS allowlists (
  list_name         TEXT NOT NULL,
  match_type        TEXT NOT NULL,  -- "exact" "contains" "regex"
  pattern           TEXT NOT NULL,
  comment           TEXT
);
