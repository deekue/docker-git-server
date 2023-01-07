# docker-git-server

simple SSH based Git server in a Docker container.

my use case is to create a read-only mirror of a Gerrit server to support partial clones+sparse checkouts (which JGit does not support).

YMMV, WIP, here be dragons.

inspired by:
   - https://github.com/jkarlosb/git-server-docker
   - https://github.com/JurrianFahner/gitserver
