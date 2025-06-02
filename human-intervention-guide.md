## Human Orchestrator Guide

As the human orchestrator, you'll be running this system over multiple sessions to build a comprehensive database of classified issues. Here's how the process works:

### Initial Setup (One-time)

1. **Clone this repository and navigate to it:**
   ```bash
   cd /home/c_byrne/projects/comfy-testing-environment/comfy-issue-classifier-agent
   ```

2. **Initialize the database:**
   ```bash
   sqlite3 comfyui_issues.db < init_database.sql
   ```

3. **Verify GitHub CLI access:**
   ```bash
   gh auth status
   gh auth login  # if needed
   gh auth refresh  # ensure you have proper repo access
   ```

4. **Test basic access:**
   ```bash
   gh api repos/comfyanonymous/ComfyUI/issues --per-page=1
   ```

### Daily Operation Workflow

This system is designed to be run across multiple days/weeks. Here's your daily routine:

#### Starting a New Session

1. **Navigate to the project directory:**
   ```bash
   cd /home/c_byrne/projects/comfy-testing-environment/comfy-issue-classifier-agent
   ```

2. **Start Claude Code and run the classification command:**
   ```bash
   claude /project:classify-comfyui-issues
   ```

3. **Review session plan:** Claude will show you:
   - Where it left off last time
   - How many issues remain to process
   - Any patterns learned from previous sessions
   - Goals for the current session

#### During the Session

- **Let Claude work autonomously** - it will process issues in batches
- **Monitor progress** - Claude will provide regular updates
- **Review low-confidence classifications** when Claude flags them
- **Guide Claude's learning** by providing feedback on classifications
- **Interrupt if needed** using Escape to provide guidance

#### Session Management

**Short Sessions (30-60 minutes):**
```bash
claude /project:classify-comfyui-issues --batch-size 25
```

**Long Sessions (2+ hours):**
```bash
claude /project:classify-comfyui-issues --batch-size 100
```

**Review-only sessions:**
```bash
claude /project:classify-comfyui-issues --report-only
```

#### End of Session

Claude will automatically:
- Save progress state
- Generate session summary
- Identify new patterns learned
- Recommend next steps
- Update meta-notes with insights

### Multi-Day Process

**Week 1-2: Initial Data Collection**
- Process newest issues first (default behavior)
- Build initial classification patterns
- Establish baseline confidence scores
- Learn common issue types and responses

**Week 3-4: Historical Processing**
- System switches to oldest unprocessed issues
- Validate patterns against historical data
- Refine classification accuracy
- Build comprehensive pattern library

**Ongoing: Maintenance Mode**
- Process new issues as they appear
- Refine existing classifications
- Update patterns based on new insights
- Generate reports and analytics

### Monitoring Progress

**Check overall progress:**
```sql
sqlite3 comfyui_issues.db "
SELECT 
  (SELECT COUNT(*) FROM classifications) as classified,
  (SELECT value FROM processing_state WHERE key='total_issues_processed') as processed,
  (SELECT COUNT(*) FROM meta_notes WHERE category='pattern') as patterns_learned
"
```

**View recent activity:**
```sql
sqlite3 comfyui_issues.db "
SELECT classification_type, COUNT(*) as count
FROM classifications 
WHERE DATE(last_updated) >= DATE('now', '-7 days')
GROUP BY classification_type
"
```

### Human Oversight Points

**Review These Classifications:**
- Any with confidence_score < 0.7
- New classification types that emerge
- Issues with unusual patterns

**Provide Feedback When:**
- Claude asks for clarification on edge cases
- New types of issues appear that don't fit existing categories
- Classification strategies need refinement

**Weekly Reviews:**
- Check classification accuracy on a sample
- Review newly discovered patterns
- Update documentation based on learnings
- Plan adjustments for next week

### Troubleshooting

**If GitHub API rate limited:**
- Wait for rate limit reset (shown in error message)
- Use smaller batch sizes
- Add delays between requests

**If database gets corrupted:**
- Backup current database: `cp comfyui_issues.db comfyui_issues_backup.db`
- Re-initialize if needed: `sqlite3 comfyui_issues.db < init_database.sql`

**If Claude loses context:**
- Use `/clear` to reset context
- Reference the README and database state
- Resume from last processed issue

### Expected Timeline

- **Initial setup:** 30 minutes
- **First week:** 2-3 hours daily, processing ~500-1000 issues
- **Subsequent weeks:** 1-2 hours daily, processing remaining backlog
- **Maintenance:** 30 minutes daily for new issues

### Success Metrics

- **Coverage:** Percentage of issues classified
- **Confidence:** Average confidence score > 0.8
- **Consistency:** Similar issues get similar classifications
- **Learning:** New patterns discovered regularly
- **Quality:** Manual review confirms accuracy

## Quick Start

## What It Does

The system will:
- Query ALL GitHub issues from `comfyanonymous/ComfyUI`
- Read issue comments for additional context
- Classify issues by their optimal response strategy
- Learn patterns over time to improve classification
- Track progress and resume where it left off
- Store meta-insights for continuous improvement

## Classification Types

- **user_error**: Common user mistakes → troubleshooting guides
- **feature_request_invalid**: Requests violating design principles → diplomatic explanations
- **how_to**: Usage questions → helpful guidance with resources
- **insufficient_info**: Unclear issues → requests for more information
- **bug_report**: Legitimate technical issues → technical acknowledgment
- **feature_request_valid**: Reasonable enhancements → discussion and consideration
- **duplicate**: Repeated issues → links to original reports

## Command Options

```bash
# Process next batch of issues (default)
claude /project:classify-comfyui-issues

# Process specific number of issues
claude /project:classify-comfyui-issues --batch-size 50

# Reset and start from beginning
claude /project:classify-comfyui-issues --reset

# Generate summary report only
claude /project:classify-comfyui-issues --report-only
```

## Database Files

- `comfyui_issues.db` - Main SQLite database
- `init_database.sql` - Database schema initialization script

## Knowledge Sources Referenced

The system references these sources for context and classification:
- ComfyUI deepwiki
- ComfyUI_frontend deepwiki
- ComfyUI-Manager deepwiki
- Comfy-Org/litegraph deepwiki
- docs.comfy.org
- blog.comfy.org
- Notion pages
- Comfy Figma pages
- Local ComfyUI repositories

## Progress Tracking

The system automatically:
- Starts from the most recent issue and works backwards
- Switches to processing oldest unprocessed issues once caught up
- Saves progress frequently to enable resumption
- Learns new patterns and improves classifications over time

## Output

Each session provides:
- Processing summary (issues classified, confidence scores)
- New patterns discovered
- Classification breakdown by type
- Recommendations for manual review of low-confidence classifications

This is a continuously learning system that gets better at classification over time as it processes more issues and discovers new patterns.