const http = require('http');
const puppeteer = require('puppeteer');
const playwright = require('playwright');

http.createServer(async (req, res) => {
  // Choose browser (Chrome for Puppeteer, Firefox for Playwright)
  const browser = await puppeteer.launch(); // or playwright.firefox.launch()

  const page = await browser.newPage();
  await page.goto('https://www.example.com');
  
  // Interact with the page as needed
  
  const screenshot = await page.screenshot();
  res.writeHead(200, { 'Content-Type': 'image/png' });
  res.end(screenshot, 'binary');

  await browser.close();
}).listen(8080);
