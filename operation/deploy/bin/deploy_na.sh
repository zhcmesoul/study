#!/bin/bash

curl -u distributor:aoka1234 -o /opt/operation/deploy/packages/njs_agent.jar http://120.77.2.93/distribute/dev/njs_agent_dev-lasted.jar
mv /opt/operation/deploy/packages/njs_agent.jar /opt/application/njs_agent/njs_agent.jar
supervisorctl restart njs_agent


