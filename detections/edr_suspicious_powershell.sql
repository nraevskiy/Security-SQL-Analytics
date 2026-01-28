-- Goal: Catch common suspicious PowerShell patterns (encoded, hidden, download cradle)
-- Tuning: add allowlists for known admin scripts, management tools, SCCM, etc.

SELECT
  event_time,
  host_name,
  user_name,
  process_name,
  process_cmdline,
  parent_name,
  parent_cmdline
FROM process_events
WHERE event_time >= NOW() - INTERVAL '7 days'
  AND lower(process_name) IN ('powershell.exe', 'pwsh.exe')
  AND (
    lower(process_cmdline) LIKE '%-enc %'
    OR lower(process_cmdline) LIKE '%-encodedcommand%'
    OR lower(process_cmdline) LIKE '%iwr %'          -- Invoke-WebRequest
    OR lower(process_cmdline) LIKE '%invoke-webrequest%'
    OR lower(process_cmdline) LIKE '%downloadstring%'
    OR lower(process_cmdline) LIKE '%frombase64string%'
    OR lower(process_cmdline) LIKE '%-w hidden%'
    OR lower(process_cmdline) LIKE '%-windowstyle hidden%'
  )
ORDER BY event_time DESC;
