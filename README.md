# Wassim Bizid — Cybersecurity & GRC portfolio

**Live:** https://bizidwassim-design.github.io/ · also at
[brainfortsecurity.com/portfolio/WassimBizid](https://www.brainfortsecurity.com/portfolio/WassimBizid/)

Cybersecurity and GRC leader: governance, identity and Zero Trust, SecOps, AI governance (ISO/IEC 42001) and
security automation. The portfolio covers 22 case studies, 16 open-source GRC and SOC projects, certifications with
the original certificates, and professional engagement.

## How this site is built

There is no copy of the portfolio in this repository. A GitHub Actions workflow builds it from its single source,
the [website repository](https://github.com/bizidwassim-design/brainfortsecurity.com), and publishes only the
portfolio page:

```
brainfortsecurity.com (Next.js)  ──  npm run build  ──►  static export
                                                          │
                              tools/assemble.sh  ◄────────┘   keeps the portfolio route, its images,
                                      │                        the hashed /_next bundle and the favicon
                                      ▼
                             GitHub Pages (this repo)
```

| File | Role |
|------|------|
| [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) | Builds and deploys on every push, on demand and once a day |
| [`tools/assemble.sh`](tools/assemble.sh) | Extracts the portfolio from the export; adds `.nojekyll`, `404.html` and the `/portfolio/` redirect |

Update the portfolio on the website, then run the workflow (**Actions → Deploy portfolio → Run workflow**) or wait for
the daily rebuild.

## Custom domain (optional)

To serve this copy on a subdomain such as `portfolio.brainfortsecurity.com`:

1. DNS (Cloudflare): add `CNAME portfolio → bizidwassim-design.github.io`, proxy **off** (DNS only).
2. GitHub: **Settings → Pages → Custom domain**, enter the subdomain, then tick **Enforce HTTPS** once the certificate is issued.
3. Verify the domain in your **account** settings (**Settings → Pages → Add a domain**) to prevent domain takeover.

## Privacy and security

Fictional data only in the projects; no client data, no secrets. The page asks search engines not to index it and
points its canonical address to the main domain. GitHub Pages cannot send custom HTTP security headers, so the main
domain (Cloudflare, with CSP and frame protection) remains the primary address.

© Wassim Bizid. All rights reserved for the portfolio content. The build scripts in this repository are MIT licensed.
