-- Hunt: Successful login after multiple failures for the same user/IP (possible brute force)
WITH failures AS (
  SELECT
    user_name,
    src_ip,
    COUNT(*) AS fail_count,
    MAX(event_time) AS last_fail_time
  FROM auth_events
  WHERE event_time >= NOW() - INTERVAL '24 hours'
    AND outcome = 'failure'
  GROUP BY 1, 2
),
successes AS (
  SELECT
    user_name,
    src_ip,
    MIN(event_time) AS first_success_time
  FROM auth_events
  WHERE event_time >= NOW() - INTERVAL '24 hours'
    AND outcome = 'success'
  GROUP BY 1, 2
)
SELECT
  f.user_name,
  f.src_ip,
  f.fail_count,
  f.last_fail_time,
  s.first_success_time
FROM failures f
JOIN successes s
  ON f.user_name = s.user_name AND f.src_ip = s.src_ip
WHERE f.fail_count >= 8
  AND s.first_success_time > f.last_fail_time
ORDER BY f.fail_count DESC;
