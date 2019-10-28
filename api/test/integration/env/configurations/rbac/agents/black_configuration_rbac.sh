#!/usr/bin/env bash

sed -i 's,"mode": "white","mode": "black",g' /var/ossec/framework/python/lib/python3.7/site-packages/api-3.11.0-py3.7.egg/api/configuration.py
sed -i "s:    # policies = RBAChecker.run_testing():    policies = RBAChecker.run_testing():g" /var/ossec/framework/python/lib/python3.7/site-packages/wazuh-3.11.0-py3.7.egg/wazuh/rbac/preprocessor.py
permissions='[{"actions":["agent:read","agent:delete","agent:restart","agent:upgrade","agent:modify_group"],"resources":["agent:id:*"],"effect":"deny"},{"actions":["agent:read"],"resources":["agent:id:001","agent:id:003","agent:id:005","agent:id:007","agent:id:009","agent:id:011"],"effect":"allow"},{"actions":["agent:delete"],"resources":["agent:id:000","agent:id:002","agent:id:004","agent:id:006","agent:id:008","agent:id:010","agent:id:012"],"effect":"allow"},{"actions":["agent:restart"],"resources":["agent:group:group2"],"effect":"allow"},{"actions":["agent:modify_group"],"resources":["agent:id:004","agent:id:005","agent:id:009","agent:id:010"],"effect":"allow"},{"actions":["agent:create"],"resources":["*"],"effect":"deny"},{"actions":["group:read","group:update_config","group:modify_assignments"],"resources":["group:id:*"],"effect":"deny"},{"actions":["group:delete"],"resources":["group:id:default","group:id:group1","group:id:group3","group:id:pepito"],"effect":"deny"},{"actions":["group:modify_assignments"],"resources":["group:id:group1"],"effect":"allow"},{"actions":["group:create"],"resources":["*"],"effect":"deny"},{"actions":["group:update_config"],"resources":["group:id:group1"],"effect":"allow"},{"actions":["group:read"],"resources":["group:id:group2","group:id:group3"],"effect":"allow"}]'
awk -v var="${permissions}" '{sub(/testing_policies = \[\]/, "testing_policies = " var)}1' /var/ossec/framework/python/lib/python3.7/site-packages/wazuh-3.11.0-py3.7.egg/wazuh/rbac/auth_context.py >> /var/ossec/framework/python/lib/python3.7/site-packages/wazuh-3.11.0-py3.7.egg/wazuh/rbac/auth_context1.py
cat /var/ossec/framework/python/lib/python3.7/site-packages/wazuh-3.11.0-py3.7.egg/wazuh/rbac/auth_context1.py > /var/ossec/framework/python/lib/python3.7/site-packages/wazuh-3.11.0-py3.7.egg/wazuh/rbac/auth_context.py

/var/ossec/bin/ossec-control restart
