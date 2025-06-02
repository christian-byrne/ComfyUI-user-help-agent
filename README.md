
## Granularize Categories



## Ingest

### Run Infinitely with Jitter Pause

```bash
while true; do
    for i in {1..8}; do
        echo "Run $i of 8"
        /home/c_byrne/projects/comfy-testing-environment/comfy-issue-classifier-agent/start.sh
        if [ $i -lt 8 ]; then
            sleep_time=$((RANDOM % 240 + 60))
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Script finished. Sleeping for $sleep_time seconds (~$((sleep_time/60)) minutes)..."
            sleep $sleep_time
        fi
    done
    echo "Completed 8 runs, running refactor command..."
    claude -p "/project:refactor-categorization-system"
    echo "Refactor completed, starting next cycle..."
done
```

### Scheduled Cron

```bash
# Create a wrapper script that runs 8 times then refactors
cat > /tmp/run_with_refactor.sh << 'EOF'
#!/bin/bash
run_count_file="/tmp/comfy_run_count"
count=$(cat "$run_count_file" 2>/dev/null || echo 0)
count=$((count + 1))
echo $count > "$run_count_file"

echo "Run $count of 8"
/home/c_byrne/projects/comfy-testing-environment/comfy-issue-classifier-agent/start.sh

if [ $count -eq 8 ]; then
    echo "Completed 8 runs, running refactor command..."
    claude -p "/project:refactor-categorization-system"
    echo 0 > "$run_count_file"
fi
EOF

chmod +x /tmp/run_with_refactor.sh

# Add to crontab
crontab -e

# Add this line:
*/20 * * * * /tmp/run_with_refactor.sh

# Set a reminder to remove it
echo "crontab -e # Remove the run_with_refactor.sh cron job" | at now + 12 hours
```

### Headless Commands

```bash
claude -p "/project:classify-comfyui-issues --resume" # resume from last session

claude -p "/project:classify-comfyui-issues" # process next batch of issues (default)

claude -p "/project:classify-comfyui-issues --batch-size 50" # process specific number of issues

claude -p "/project:classify-comfyui-issues --reset" # reset and start from beginning

claude -p "/project:classify-comfyui-issues --report-only" # generate summary report only
```
