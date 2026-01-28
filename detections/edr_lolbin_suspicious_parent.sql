-- Goal: LOLBins launched by suspicious parents (Office, browser, temp paths)
-- Note: parent-process analytics is high value for detection engineering.

SELECT
  event_time,
  host_name,
  user_name,
  process_name,
  process_path,
  parent_name,
  parent_path,
  process_cmdline
FROM process_events
WHERE event_time >= NOW() - INTERVAL '14 days'
  AND lower(process_name) IN ('rundll32.exe','regsvr32.exe','mshta.exe','wscript.exe','cscript.exe','certutil.exe','bitsadmin.exe')
  AND (
    lower(parent_name) IN ('winword.exe','excel.exe','powerpnt.exe','outlook.exe','chrome.exe','msedge.exe','firefox.exe')
    OR lower(parent_path) LIKE '%\\appdata\\local\\temp\\%'
    OR lower(process_path) LIKE '%\\appdata\\local\\temp\\%'
  )
ORDER BY event_time DESC;
