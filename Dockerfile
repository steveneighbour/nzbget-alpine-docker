#FROM hypriot/rpi-alpine-scratch

FROM scratch
LABEL architecture="ARMv7"

# copy init files
RUN mkdir /setup
COPY setup/* /setup/

# make the escripts executable and run the setup
RUN chmod -v +x /setup/*.sh && sh /setup/setup.sh

# delete all the setup files
RUN rm -r /setup/

# volume mappings
VOLUME /config /downloads

# exposes nzbget's default port
EXPOSE 6789

# not root anymore going forward
USER nzbget

# set some defaults and start nzbget in server and log mode
ENTRYPOINT ["/nzbget/nzbget", "-s", "-o", "OutputMode=log", "-c", "/config/nzbget.conf"]
