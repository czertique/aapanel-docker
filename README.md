# Install procedure

1. Copy repo contents to any directory on your server
1. Run `make build` as a user with docker engine privileges

This produces docker image named `$IMAGE_TAG` as defined in Makefile.
You may either use the image locally, or push it to docker registry
of your choice and update compose file accordingly.

# How to start
1. Create a work directory for aaPanel. Application root is defined in
`.env` file and is `/docker/aapanel` as default.
1. Copy `.env` and `docker-compose.yml` to work directory.
1. Create `data` subdirectory in work directory, so it will look as follows

```
# ls -la
total 20
drwxr-xr-x 3 root root 4096 Feb 12 17:32 .
drwxr-xr-x 6 root root 4096 Feb 10 13:42 ..
-rw-r--r-- 1 root root   66 Feb 12 14:00 .env
drwxr-xr-x 7 root root 4096 Feb 12 16:35 data
-rw-r--r-- 1 root root  445 Feb 12 15:31 docker-compose.yml
```

1. Run `docker-compose up -d && docker-compose logs`
