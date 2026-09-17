// Run after lime build html5 -debug. Uses an existing Playwright installation.
const http = require('node:http');
const fs = require('node:fs/promises');
const path = require('node:path');
const { chromium } = require(process.env.PLAYWRIGHT_MODULE || 'playwright');
const root = path.resolve(__dirname, 'Export/html5/bin');
const mime = {'.html':'text/html','.js':'text/javascript','.json':'application/json','.png':'image/png'};
(async () => {
  const server = http.createServer(async (req, res) => {
    try {
      const pathname = decodeURIComponent(new URL(req.url, 'http://localhost').pathname);
      const file = path.resolve(root, '.' + (pathname === '/' ? '/index.html' : pathname));
      if (!file.startsWith(root + path.sep)) { res.writeHead(403).end(); return; }
      const data = await fs.readFile(file);
      res.writeHead(200, {'Content-Type':mime[path.extname(file)] || 'application/octet-stream'});
      res.end(data);
    } catch { res.writeHead(404).end(); }
  });
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  let browser;
  try {
    const options = {headless:true};
    if (process.env.BROWSER_CHANNEL) options.channel = process.env.BROWSER_CHANNEL;
    browser = await chromium.launch(options);
    const page = await browser.newPage({viewport:{width:960,height:640}});
    const errors = [];
    page.on('pageerror', error => errors.push(error.message));
    await page.goto(`http://127.0.0.1:${server.address().port}/`);
    await page.waitForFunction(() => window.chartHarnessResult, null, {timeout:15000});
    const result = await page.evaluate(() => window.chartHarnessResult);
    if (!result.ok || errors.length) throw Error(JSON.stringify({result,errors}));
    const pointer = await page.evaluate(() => window.chartHarnessPointer);
    await page.mouse.click(pointer.x, pointer.y);
    await page.mouse.click(pointer.x, pointer.y);
    const interaction = await page.evaluate(() => window.chartHarnessPointer);
    if (interaction.clicks !== 2 || interaction.changes !== 1) throw Error('Native pointer regression: ' + JSON.stringify(interaction));
    console.log('PASS native browser pointer: two clicks, one selection change');
    await page.screenshot({path:path.join(root, 'phase1-baseline.png')});
    console.log('PASS browser harness: ' + JSON.stringify(result));
    console.log('Screenshot: ' + path.join(root, 'phase1-baseline.png'));
  } finally {
    if (browser) await browser.close();
    await new Promise(resolve => server.close(resolve));
  }
})().catch(error => { console.error(error); process.exitCode = 1; });



