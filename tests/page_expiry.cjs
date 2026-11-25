// Docassemble flashes CSRF failures as success alerts. They still reject input.
module.exports = async function assertNoPageExpiry(page) {
  const expired = await page.$$eval('.alert', alerts => alerts.some(alert =>
    /Input not processed because the page expired/i.test(alert.textContent || '')
  ));
  if (expired) throw Error('Docassemble rejected input because the page expired; preserve artifacts and rerun this scenario independently.');
};
