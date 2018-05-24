-- Whitelist 'www[0-9].badboy.cz'
policy.add(policy.pattern(policy.PASS, '\4www[0-9]\6badboy\2cz'))

-- Block all names below badboy.cz
policy.add(policy.suffix(policy.DENY, {todname('badboy.cz.')}))

-- Enforce local RPZ
policy.add(policy.rpz(policy.DENY, 'blacklist.rpz'))

-- Forward all queries below 'company.se' to given resolver
policy.add(policy.suffix(
  policy.FORWARD('192.168.1.1'), {todname('company.se')}
))

-- Forward all queries matching pattern
policy.add(policy.pattern(
  policy.FORWARD('2001:DB8::1'), '\4bad[0-9]\2cz'
))

-- Forward all queries (to public resolvers https://www.nic.cz/odvr)
policy.add(policy.all(
  policy.FORWARD({'2001:678:1::206', '193.29.206.206'})
))

-- Print all responses with matching suffix
policy.add(policy.suffix(
  policy.QTRACE, {todname('rhybar.cz.')}
))

-- Print all responses
policy.add(policy.all(policy.QTRACE))

-- Custom rule
policy.add(function (req, query)
        if query:qname():find('%d.%d.%d.224\7in-addr\4arpa') then
                return policy.DENY
        end
end)

-- Disallow ANY queries
policy.add(function (req, query)
        if query.stype == kres.type.ANY then
                return policy.DROP
        end
end)


-- Mirror all queries and retrieve information
local rule = policy.add(policy.all(policy.MIRROR('127.0.0.2')))
-- Print information about the rule
print(string.format('id: %d, matched queries: %d', rule.id, rule.count)

