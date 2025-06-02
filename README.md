## Run Infinitely with Jitter Pause

```bash
while true; do
    /home/c_byrne/projects/comfy-testing-environment/comfy-issue-classifier-agent/start.sh
    sleep_time=$((RANDOM % 240 + 60))
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Script finished. Sleeping for $sleep_time seconds (~$((sleep_time/60)) minutes)..."
    sleep $sleep_time
done
```

## Scheduled Cron

```bash
# Add to crontab
crontab -e

# Add this line:
*/20 * * * * /home/c_byrne/projects/comfy-testing-environment/comfy-issue-classifier-agent/start.sh

# Set a reminder to remove it
echo "crontab -e # Remove the start.sh cron job" | at now + 12 hours
```

## Headless Commands

```bash
claude -p "/project:classify-comfyui-issues --resume" # resume from last session

claude -p "/project:classify-comfyui-issues" # process next batch of issues (default)

claude -p "/project:classify-comfyui-issues --batch-size 50" # process specific number of issues

claude -p "/project:classify-comfyui-issues --reset" # reset and start from beginning

claude -p "/project:classify-comfyui-issues --report-only" # generate summary report only
```
