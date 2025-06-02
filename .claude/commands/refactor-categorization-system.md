# Refactor ComfyUI Issue Categorization System

You are a data analyst and system architect tasked with refactoring the ComfyUI issue categorization system to optimize for response effectiveness rather than just issue types.

## Context
The current categorization system in this repository is hardcoded and based on the nature of issues. However, we want to reorganize categories based on what the optimal response type should be, creating semantic partitions that better align with how issues should be handled.

## Task Overview
<instructions>
1. Analyze the current database structure and categorization system
2. Examine existing categories to identify response-based patterns
3. Propose new subcategories based on optimal response types
4. Update database schema and data accordingly
5. Update all related documentation and scripts
6. Validate the new system works correctly
</instructions>

## Step-by-Step Process

### Phase 1: Analysis and Discovery
<analysis_steps>
1. **Database Analysis**
   - Examine the comfyui_issues.db structure and content
   - Document current categorization schema
   - Identify all tables, fields, and relationships

2. **Classification System Review**
   - Read `.claude/commands/classify-comfyui-issues.md` thoroughly
   - Document the current hardcoded categorization logic
   - Identify all current categories and their definitions

3. **Pattern Recognition**
   - For each existing category, analyze the types of responses that are most effective
   - Look for patterns where similar response strategies work across different issue types
   - Identify categories that could be split based on response methodology rather than issue content
</analysis_steps>

### Phase 2: Response-Based Categorization Design
<design_steps>
1. **Response Strategy Identification**
   - Group issues by optimal response patterns (e.g., "needs code example", "needs configuration guidance", "needs troubleshooting steps", "needs referral to documentation")
   - Identify subcategories where the semantic difference is the response approach, not the issue type

2. **New Schema Design**
   - Design new database schema that supports response-based categorization
   - Plan migration strategy from old to new system
   - Ensure backward compatibility where needed

3. **Validation Framework**
   - Create criteria for validating that new categories improve response effectiveness
   - Define metrics for measuring categorization success
</design_steps>

### Phase 3: Implementation
<implementation_steps>
1. **Database Migration**
   - Create backup of existing database
   - Implement new schema
   - Migrate existing data to new categorization system
   - Validate data integrity

2. **Documentation Updates**
   - Update `classify-comfyui-issues.md` with new categorization logic
   - Update any other relevant documentation files
   - Update scripts that depend on categorization

3. **System Testing**
   - Test the new categorization system
   - Verify all scripts and processes work with new categories
   - Validate that new system better aligns responses with issue needs
</implementation_steps>

## Execution Instructions

**Start by using the TodoWrite tool to plan your work:**
- Break down each phase into specific, actionable todos
- Mark todos as in_progress when working on them
- Complete todos as you finish each step

**For each category you analyze:**
1. Document the current definition and typical issues
2. Analyze response patterns for issues in that category
3. Identify potential subcategories based on optimal response types
4. Propose new categorization approach
5. Validate the approach makes semantic sense

**When updating the system:**
- Always create backups before making changes
- Test thoroughly after each change
- Update documentation immediately after code changes
- Use clear commit messages describing the categorization improvements

## Key Principles
- Optimize for response effectiveness, not just issue classification
- Maintain semantic coherence within new categories
- Ensure the new system is more actionable than the current one
- Preserve important historical categorization data where possible

## Output Requirements
When complete, provide:
1. Summary of changes made to categorization system
2. Explanation of how new categories better align with optimal responses
3. Documentation of the migration process
4. Validation that the new system works correctly

Begin by examining the database and existing categorization system, then use the TodoWrite tool to plan your systematic analysis and refactoring work.