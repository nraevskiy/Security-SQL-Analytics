-- Audit: New admin privilege grants / policy attachments / role assignments
-- Adapt action names per cloud/provider. This query focuses on IAM-ish changes.

SELECT
  event_time,
  cloud,
  account_id,
  actor_name,
  actor_type,
  src_ip,
  service,
  action,
  resource_type,
  resource_id,
  outcome
FROM cloud_audit
WHERE event_time >= NOW() - INTERVAL '30 days'
  AND outcome = 'success'
  AND (
    -- AWS-like
    lower(action) IN ('attachuserpolicy','attachrolepolicy','putuserpolicy','putrolepolicy','createaccesskey','addusertogroup')
    -- Azure-like / GCP-like examples (adjust to your normalized names)
    OR lower(action) LIKE '%roleassignment%'
    OR lower(action) LIKE '%setiampolicy%'
  )
ORDER BY event_time DESC;
