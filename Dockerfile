# Use a base image with Node.js and a Linux distribution
FROM node:14

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    xvfb \
    libgtk-3-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    unzip

# Install Puppeteer
RUN npm install puppeteer

# Install Playwright
RUN npm install playwright

# Install Chrome and Firefox
RUN wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i /tmp/chrome.deb && \
    apt-get install -fy && \
    wget -O /tmp/firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64" && \
    tar xjf /tmp/firefox.tar.bz2 -C /opt/ && \
    ln -s /opt/firefox/firefox /usr/bin/firefox

# Install VNC server and web server
RUN apt-get install -y \
    x11vnc \
    websockify

# Set up a workspace directory
WORKDIR /app

# Copy your application files (e.g., server.js) into the container
COPY server.js /app/

# Expose VNC and web server ports
EXPOSE 5900 8080

# Start the VNC server, web server, and your application
CMD ["sh", "-c", "xvfb-run -s '-screen 0 1280x720x24' node /app/server.js & x11vnc -display :0 -nopw -forever & websockify 8080 localhost:5900"]
