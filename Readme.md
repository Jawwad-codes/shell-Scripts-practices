# 18 Days of Shell Scripting — DevOps Edition

This started out as a bigger plan, but after trimming a couple of tasks that needed extra setup, it settled into an 18-day challenge. Goal was to get comfortable writing real Bash scripts for DevOps work — not just learning syntax, but solving actual problems I'd run into as a sysadmin/DevOps engineer: disk checks, log parsing, Docker cleanup, deployments, and so on.

Each day is its own folder under `shell Scripts practices/DayN/`, with a standalone `.sh` file (some days have more than one variant, where I tried the same problem two different ways).

## Why I'm doing this

I already know Docker, Terraform, GitHub Actions from other work, but I realized I was leaning on tools instead of plain shell whenever something small needed automating. This challenge is about closing that gap — writing scripts myself before reaching for anything else.

**Rule I'm following:** try to write it myself for ~20 minutes before looking anything up. If I'm stuck after that, debug from the error message, not by asking for a full solution.

---

## Day-by-day

### Day 1 — System Information
`system_info.sh`

Prints the basics about the machine: hostname, OS, kernel version, uptime, CPU info, memory, disk usage, IP address, current user, current date.

### Day 2 — Disk Usage Alert
`disk_check.sh`

Checks `/` usage with `df` + `awk`. If it's above 80%, prints a warning and exits non-zero so it can be used in a cron job or CI step. Otherwise prints that things are healthy.

### Day 3 — Automated Backup
`backup.sh`

Usage: `./backup.sh /var/log`

Tars and compresses the given directory, filename includes today's date, e.g. `logs_2026-09-05.tar.gz`. Uses `$1`, `mkdir -p`, `date`.

### Day 4 — Log Analyzer
`log_analyzer.sh` (tested against `access.log`)

Parses a log file and reports total lines, ERROR/WARNING/INFO counts, and the top 5 most frequent IPs. Mostly `grep`, `awk`, `sort | uniq -c`.

### Day 5 — Process Checker
`process_check.sh`

Usage: `./process_check.sh nginx`

Checks with `pgrep` whether a process is running and prints a plain yes/no style result.

### Day 6 — Service Health Checker
`service_check.sh` + `service_check_using_Sytemctl.sh`

I wrote this one twice — once doing a more manual check, once leaning fully on `systemctl is-active`/`is-enabled`. Supports checking multiple services in one call:

```bash
./service_check.sh nginx ssh prometheus grafana-server
```

### Day 7 — Log Cleanup
`cleanup_log.sh`

Finds `.log` files older than 7 days with `find -mtime +7`, lists them, and asks for confirmation before deleting anything with `read`.

### Day 8 — Linux User Management
`create_users.sh`

Usage: `./create_users.sh dev1 dev2 dev3`

Loops through usernames, checks with `id` if each already exists, creates missing ones with `useradd`.

### Day 9 — Port Checker
`port_check.sh`

Usage: `./port_check.sh 22 80 443 3000 9090`

Loops over a list of ports and reports OPEN/CLOSED using `ss`/`nc`.

### Day 10 — Website Health Checker
`website_check.sh`

Usage: `./website_check.sh https://example.com`

Uses `curl` to grab HTTP status code and response time, then prints a simple health verdict.

### Day 11 — Docker Container Health
`docker_check.sh`

Lists running containers and their status via `docker ps`/`docker inspect`, and separately flags stopped ones.

### Day 12 — Docker Cleanup
`docker_cleanup.sh`

Finds stopped containers, dangling images, and unused volumes, then asks for confirmation before running the cleanup — didn't want a script that nukes things silently.

### Day 13 — Git Repository Backup
`git_backup.sh`

Usage: `./git_backup.sh /path/to/project`

Confirms the target is a git repo, checks status, grabs the current commit hash, and creates a backup archive with the commit hash baked into the filename.

### Day 14 — Application Deployment
`deploy.sh`

Pulls latest code, builds the Docker image, stops the old container, starts the new one, then hits the app's health endpoint to confirm it actually came up. This one took longer than the 30-minute budget — chaining git + Docker + a health check in one script has more edge cases than it looks like on paper.

### Day 15 — Environment Validator
`validate_env.sh` + `validation_cicd_env.sh`

Checks that required env vars (`DATABASE_URL`, `APP_ENV`, `PORT`, etc.) are actually set before a deploy runs, and fails loudly if any are missing. Wrote a second version aimed specifically at a CI/CD context.

### Day 16 — Server Health Report
`health_report.sh`

Pulls together hostname, uptime, CPU, memory, disk, running services, open ports, Docker containers, and top processes into one readable report using functions for each section.

### Day 17 — Log Archive System
`log_archive.sh`

Finds logs older than 7 days, compresses them into an archive directory, and only deletes the originals if compression actually succeeded — logs every step. The "don't delete unless the previous step succeeded" pattern was the main thing I wanted to practice here.

### Day 18 — DevOps Toolkit
`devops_scripting_tool_kit.sh`

The final piece — wraps most of the above into one interactive menu-driven script, each option calling a function:

```
================================
          DEVOPS TOOLKIT
================================
1. System Information
2. Disk Check
3. Service Check
4. Docker Status
5. Port Check
6. Website Health
7. Log Analyzer
8. Server Health Report
9. Docker Cleanup
10. Exit
```

---

## Project structure

```
shell Scripts practices/
│
├── Day1/   system_info.sh
├── Day2/   disk_check.sh
├── Day3/   backup.sh
├── Day4/   access.log, log_analyzer.sh
├── Day5/   process_check.sh
├── Day6/   service_check.sh, service_check_using_Sytemctl.sh
├── Day7/   cleanup_log.sh
├── Day8/   create_users.sh
├── Day9/   port_check.sh
├── Day10/  website_check.sh
├── Day11/  docker_check.sh
├── Day12/  docker_cleanup.sh
├── Day13/  git_backup.sh
├── Day14/  deploy.sh
├── Day15/  validate_env.sh, validation_cicd_env.sh
├── Day16/  health_report.sh
├── Day17/  log_archive.sh
└── Day18/  devops_scripting_tool_kit.sh
```

## What I'm taking away from this

Mostly that shell scripting for DevOps isn't about clever one-liners — it's about handling the failure cases: what happens if compression fails, if a container doesn't come back up, if a required env var is missing. The toolkit script at the end forced me to actually reuse and clean up code from earlier days instead of writing everything as a one-off.

Still a couple of tasks I'm parking for later, once I have a proper environment to test them against without breaking anything.