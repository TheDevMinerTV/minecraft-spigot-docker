# Minecraft Spigot 1.14.3 Dockerfile - Example with notes

# Use the offical Ubuntu Docker image with a specified version tag, Bionic, so not all
# versions of Ubuntu images are downloaded.
FROM ubuntu:bionic

MAINTAINER TheDevMinerTV <tobigames200@gmail.com>

# Drives which version we are going to install
ENV SPIGOT_VERSION 1.14.3

# Use APT (Advanced Packaging Tool) built in the Linux distro to download Java, a dependency
# to run Minecraft.
# First, we need to ensure the right repo is available for JRE 8
# Then we update apt
# Then we pull in all of our dependencies,
# Finally, we download the correct .jar file using wget
# .jar file fetched from the official page spigot page https://cdn.getbukkit.org/spigot/spigot-<VERSION>.jar

RUN apt update && apt install -y openjdk-8-jre-headless ca-certificates-java wget nano; \
    wget -q https://cdn.getbukkit.org/spigot/spigot-${SPIGOT_VERSION}.jar -O /minecraft_server-${SPIGOT_VERSION}.jar;
# We do the above in a single line to reduce the number of layers in our container

# Sets working directory for the CMD instruction (also works for RUN, ENTRYPOINT commands)
# Create mount point, and mark it as holding externally mounted volume
WORKDIR /data
VOLUME /data

# Expose the container's network port: 25565 during runtime.
EXPOSE 25565

#Automatically accept Minecraft EULA, and start Minecraft server
CMD echo eula=true > /data/eula.txt && java -jar /minecraft_server-${SPIGOT_VERSION}.jar
