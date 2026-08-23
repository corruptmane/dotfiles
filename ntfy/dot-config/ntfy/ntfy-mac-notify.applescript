-- ntfy macOS notification handler
-- Install to: ~/.config/ntfy/mac-notify.applescript
--
-- ntfy passes message metadata as NTFY_* environment variables; reading them
-- via `system attribute` avoids all shell-quoting issues entirely.
--
-- Wire up in ~/.config/ntfy/client.yml with:
--   command: /usr/bin/osascript /Users/corrupt/.config/ntfy/mac-notify.applescript

set msg to system attribute "NTFY_MESSAGE"
set ttl to system attribute "NTFY_TITLE"
set top to system attribute "NTFY_TOPIC"
set prio to system attribute "NTFY_PRIORITY"

-- fall back to the topic name when the publisher sent no title
if ttl is "" then set ttl to top

-- audible ping for high-priority messages
if prio is "4" or prio is "5" then
	display notification msg with title ttl sound name "Glass"
else
	display notification msg with title ttl
end if
