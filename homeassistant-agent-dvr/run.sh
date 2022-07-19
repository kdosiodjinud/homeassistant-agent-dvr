#!/bin/bash

echo "Create configs"
runuser -l agentdvr -c '/home/agentdvr/AgentDVR/.dotnet/dotnet /home/agentdvr/AgentDVR/Agent.dll & sleep 10 && kill "$!"'

sleep 10

echo "Link data to persist in hassio"
  cd /home/agentdvr/AgentDVR

  if [ ! -d "/data/XML" ]
  then
    cp -R XML /data/
  fi
  rm -rf XML
  ln -s /data/XML/

  if [ ! -d "/data/Commands" ]
  then
    cp -R Commands /data/
  fi
  rm -rf Commands
  ln -s /data/Commands/

  if [ ! -d "/data/Media" ]
  then
    cp -R Media /data/
  fi
  rm -rf Media
  ln -s /data/Media/

  chmod -R 777 /data/
  chown -R agentdvr:agentdvr /data/

echo "Run AgentDVR with persisted configuration"
runuser -l agentdvr -c '/home/agentdvr/AgentDVR/.dotnet/dotnet /home/agentdvr/AgentDVR/Agent.dll'

for (( ; ; ))
do
   echo "Agent DVR failed!"
   sleep 60
done
