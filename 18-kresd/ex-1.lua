-- Config file example useable for multi-user ISP resolver
-- Refer to manual: https://knot-resolver.readthedocs.io/en/latest/daemon.html#configuration

-- Listen on localhost and external interface
net = { '127.0.0.1', '::1', '192.168.1.1' }

-- Drop root privileges
user('knot-resolver', 'knot-resolver')

-- Auto-maintain root TA
trust_anchors.file = 'root.keys'

-- Large cache size, so we don't need to flush often
-- This can be larger than available RAM, least frequently accessed
-- records will be paged out
cache.size = 4 * GB

-- Load Useful modules
modules = {
	'policy',   -- Block queries to local zones/bad sites
	'view',     -- Views for certain clients
	'hints',    -- Load /etc/hosts and allow custom root hints
	'stats',    -- Track internal statistics
	graphite = { -- Send statistics to local InfluxDB
		-- `worker.id` allows us to keep per-fork statistics
		prefix = hostname()..worker.id,
		-- Address of the Graphite/InfluxDB server
		host = '192.168.1.2',
	}
}

