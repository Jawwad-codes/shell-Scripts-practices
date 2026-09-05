#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

function show_menu() {
    echo "================== DevOps Scripting Tool Kit =================="
    echo "1.  System information"
    echo "2.  Disk usage"
    echo "3.  Backup a directory"
    echo "4.  Log Analysis"
    echo "5.  Process Check"
    echo "6.  Service check using systemctl"
    echo "7.  Service check"
    echo "8.  Clean up old log files"
    echo "9.  Create User"
    echo "10. Port check"
    echo "11. Website health check"
    echo "12. Docker check"
    echo "13. Docker cleanup"
    echo "14. Git backup of a repository"
    echo "15. Deploy a web application"
    echo "16. Validate environment variables"
    echo "17. Validate environment variables from CI/CD pipeline"
    echo "18. Server Health Report"
    echo "19. Log Archive (older than 7 days)"
    echo "0.  Exit"
    echo "==============================================================="
}

function system_info()             { bash "$BASE_DIR/Day1/system_info.sh"; }
function disk_usage()              { bash "$BASE_DIR/Day2/disk_check.sh"; }
function backup_directory()        { bash "$BASE_DIR/Day3/backup.sh"; }
function log_analysis()            { bash "$BASE_DIR/Day4/log_analyzer.sh"; }
function process_check()           { bash "$BASE_DIR/Day5/process_check.sh"; }
function service_check_systemctl() { bash "$BASE_DIR/Day6/service_check_using_Sytemctl.sh"; }
function service_check()           { bash "$BASE_DIR/Day6/service_check.sh"; }
function cleanup_old_logs()        { bash "$BASE_DIR/Day7/cleanup_log.sh"; }
function create_user()             { bash "$BASE_DIR/Day8/create_users.sh"; }
function port_check()              { bash "$BASE_DIR/Day9/port_check.sh"; }
function website_health_check()    { bash "$BASE_DIR/Day10/website_check.sh"; }
function docker_check()            { bash "$BASE_DIR/Day11/docker_check.sh"; }
function docker_cleanup()          { bash "$BASE_DIR/Day12/docker_cleanup.sh"; }
function git_backup()              { bash "$BASE_DIR/Day13/git_backup.sh"; }
function deploy_web_app()          { bash "$BASE_DIR/Day14/deploy.sh"; }
function validate_env_vars()       { bash "$BASE_DIR/Day15/validate_env.sh"; }
function validate_env_vars_ci_cd() { bash "$BASE_DIR/Day15/validation_cicd_env.sh"; }
function server_health_report()    { bash "$BASE_DIR/Day16/health_report.sh"; }
function log_archive()             { bash "$BASE_DIR/Day17/log_archive.sh"; }

# ---- Main loop ----
while true; do
    show_menu
    read -rp "Choose an option: " choice
    echo ""

    case "$choice" in
        1)  system_info ;;
        2)  disk_usage ;;
        3)  backup_directory ;;
        4)  log_analysis ;;
        5)  process_check ;;
        6)  service_check_systemctl ;;
        7)  service_check ;;
        8)  cleanup_old_logs ;;
        9)  create_user ;;
        10) port_check ;;
        11) website_health_check ;;
        12) docker_check ;;
        13) docker_cleanup ;;
        14) git_backup ;;
        15) deploy_web_app ;;
        16) validate_env_vars ;;
        17) validate_env_vars_ci_cd ;;
        18) server_health_report ;;
        19) log_archive ;;
        0)  echo "Goodbye!"; exit 0 ;;
        *)  echo "Invalid option, try again." ;;
    esac

    echo ""
    read -rp "Press Enter to continue..." _
    clear
done