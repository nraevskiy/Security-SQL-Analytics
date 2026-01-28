-- Hunt: Identify domains rarely seen on a host (useful for initial access / C2)
-- Idea: For each host, compare last 24h domains to previous 30d baseline

WITH baseline AS (
  SELECT
    host_name,
    query_name,
    COUNT(*) AS cnt_30d
  FROM dns_logs
  WHERE event_time >= NOW() - INTERVAL '30 days'
    AND event_time <  NOW() - INTERVAL '24 hours'
  GROUP BY 1, 2
),
recent AS (
  SELECT
    host_name,
    query_name,
    COUNT(*) AS cnt_24h
  FROM dns_logs
  WHERE event_time >= NOW() - INTERVAL '24 hours'
  GROUP BY 1, 2
)
SELECT
  r.host_name,
  r.query_name,
  r.cnt_24h,
  COALESCE(b.cnt_30d, 0) AS cnt_30d
FROM recent r
LEFT JOIN baseline b
  ON r.host_name = b.host_name AND r.query_name = b.query_name
WHERE COALESCE(b.cnt_30d, 0) = 0
  AND r.cnt_24h >= 3
ORDER BY r.cnt_24h DESC;
