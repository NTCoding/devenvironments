FROM node:8-stretch

# Xvfb
RUN apt-get update -qqy \
    && apt-get -qqy install xvfb \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update -qqy \
    && apt-get -qqy install google-chrome-stable \
    && rm /etc/apt/sources.list.d/google-chrome.list \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && sed -i 's/"$HERE\/chrome"/xvfb-run "$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome

RUN apt-get update && apt-get install -y openjdk-8-jre

RUN npm install -g webdriverio
RUN npm install -g wdio
RUN npm install -g chromedriver --unsafe-perm=true --allow-root
RUN npm install -g wdio-selenium-standalone-service
RUN npm install -g wdio-mocha-framework

# Prepare app directory
RUN mkdir -p /app
ADD . /app

# Install dependencies
WORKDIR /app
RUN npm install --unsafe-perm=true --allow-root

# Build the app
RUN npm build

# Expose the app port
EXPOSE 3000

# Start chrome
CMD sleep infinity
