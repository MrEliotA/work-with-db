# work-with-DB

Repository for **hands-on DB operations**. Educational and ready-for-use.

> Language of explanations: Persian · **All code comments are in English**

## Branching Strategy
- `mysql` — current branch (this starter)
- `mariadb` — planned
- `postgresql` — planned

Use one branch per database engine to keep configs and docs clean.

## Quick Start (MySQL branch)

```bash
# Create repo and mysql branch locally
git init
git add .
git commit -m "chore: bootstrap mysql branch"
git branch -M mysql

# (Optional) Create a remote and push
# git remote add origin <YOUR_GITHUB_REPO_URL>
# git push -u origin mysql
```

Then run:

```bash
docker compose up -d
```

More docs in `docs/README.mysql.md`.
