# Let's start with a basic HAProxy box
FROM dockerfile/haproxy

# I'm using docker via TCP, so I can't use the default "docker -v" to mount my override.
ADD haproxy-override/haproxy.cfg /etc/haproxy/haproxy.cfg