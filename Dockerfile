# ----------------------------------------
#
# This image inherits uoa-inzight-probability-base image 
# and installs the Probability shiny app
#
# ----------------------------------------
FROM scienceis/uoa-inzight-probability-base:latest

MAINTAINER "Science IS Team" ws@sit.auckland.ac.nz

# Edit the following environment variable, commit to Github and it will trigger Docker build
# Since we fetch the latest changes from the associated Application~s master branch
# this helps trigger date based build
# The other option would be to tag git builds and refer to the latest tag
ENV LAST_BUILD_DATE "2016-01-25 1:45 PM NZDT"

# Install (via R) all of the necessary packages (R will automatially install dependencies):
RUN rm -rf /srv/shiny-server/* \
  && wget --no-verbose -O Probability.zip https://github.com/iNZightVIT/Probability/archive/master.zip \
  && unzip Probability.zip \
  && cp -R Probability-master/* /srv/shiny-server \
  && echo $LAST_BUILD_DATE > /srv/shiny-server/build.txt \
  && rm -rf Probability.zip Probability-master/ \
  && rm -rf /tmp/* /var/tmp/*

# start shiny server process - it listens to port 3838
CMD ["/opt/shiny-server.sh"]
