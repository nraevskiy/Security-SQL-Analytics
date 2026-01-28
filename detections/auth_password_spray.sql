-- Goal: Detect password spraying against multiple users from a single IP
-- Tuning knobs:
--   - window size (e.g., 15m / 30m)
--   - thresholds: distinct_users, total_failures
-- Expected FPs: VPN gateways, misconfigured apps, shared NAT egress

WITH windowed AS (
  SELECT
    date_trunc('minute', event_time) AS minute_bucket,
    src_ip,
    COUNT(*) FILTER (WHERE outcome = 'failure') AS failures,
    COUNT(DISTINCT user_name) FILTER (WHERE outcome = 'failure') AS distinct_users
  FROM auth_events
  WHERE event_time >= NOW() - INTERVAL '24 hours'
    AND src_ip IS NOT NULL
  GROUP BY 1, 2
),
flagged AS (
  SELECT *
  FROM windowed
  WHERE failures >= 20
    AND distinct_users >= 10
)
SELECT
  f.minute_bucket,
  f.src_ip,
  f.failures,
  f.distinct_users
FROM flagged f
ORDER BY f.failures DESC;
