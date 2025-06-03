-- Migrate existing classification data to enhanced response-based system
-- This script updates existing records to use the new categorization system

-- Step 1: Update classifications that have null response_category based on classification_type
UPDATE classifications 
SET 
    response_category = (SELECT new_category FROM classification_migration WHERE old_type = classifications.classification_type),
    response_subcategory = (SELECT new_subcategory FROM classification_migration WHERE old_type = classifications.classification_type),
    confidence_score = COALESCE(confidence_score, (SELECT confidence FROM classification_migration WHERE old_type = classifications.classification_type))
WHERE response_category IS NULL 
AND classification_type IN (SELECT old_type FROM classification_migration);

-- Step 2: Set response strategy based on response category
UPDATE classifications 
SET response_strategy = 
    CASE response_category
        WHEN 'needs_information' THEN 'request_details'
        WHEN 'needs_guidance' THEN 'provide_tutorial'
        WHEN 'needs_technical_review' THEN 'technical_analysis'
        WHEN 'needs_clarification' THEN 'clarify_requirements'
        WHEN 'needs_redirection' THEN 'redirect_appropriately'
        WHEN 'needs_troubleshooting' THEN 'guided_resolution'
        WHEN 'needs_community_engagement' THEN 'community_collaboration'
        WHEN 'needs_documentation' THEN 'create_documentation'
        ELSE 'general_support'
    END
WHERE response_strategy IS NULL;

-- Step 3: Set response urgency based on subcategory
UPDATE classifications 
SET response_urgency = 
    CASE response_subcategory
        WHEN 'missing_reproduction_steps' THEN 'high'
        WHEN 'missing_system_info' THEN 'high'  
        WHEN 'missing_error_logs' THEN 'high'
        WHEN 'bug_investigation' THEN 'high'
        WHEN 'already_resolved' THEN 'low'
        WHEN 'wrong_repository' THEN 'low'
        WHEN 'user_mistake' THEN 'medium'
        WHEN 'configuration_error' THEN 'medium'
        WHEN 'feature_evaluation' THEN 'low'
        WHEN 'community_discussion' THEN 'low'
        WHEN 'workflow_tutorial' THEN 'medium'
        ELSE 'medium'
    END
WHERE response_urgency = 'medium';

-- Step 4: Set required expertise level
UPDATE classifications 
SET requires_expertise = (
    SELECT expertise_level 
    FROM response_categories 
    WHERE response_categories.category = classifications.response_category 
    AND response_categories.subcategory = classifications.response_subcategory
)
WHERE requires_expertise IS NULL;

-- Step 5: Set estimated response time
UPDATE classifications 
SET estimated_response_time = (
    SELECT typical_response_time 
    FROM response_categories 
    WHERE response_categories.category = classifications.response_category 
    AND response_categories.subcategory = classifications.response_subcategory
)
WHERE estimated_response_time IS NULL;

-- Step 6: Update last_updated timestamp for migrated records
UPDATE classifications 
SET last_updated = CURRENT_TIMESTAMP 
WHERE response_strategy IS NOT NULL;

-- Analysis: Show migration results
SELECT 
    'Migration Summary' as type,
    COUNT(*) as total_records,
    COUNT(CASE WHEN response_category IS NOT NULL THEN 1 END) as categorized_records,
    COUNT(CASE WHEN response_strategy IS NOT NULL THEN 1 END) as strategy_assigned,
    ROUND(COUNT(CASE WHEN response_category IS NOT NULL THEN 1 END) * 100.0 / COUNT(*), 2) as categorization_percentage
FROM classifications;

-- Show distribution of new categories
SELECT 
    response_category,
    response_subcategory,
    response_urgency,
    requires_expertise,
    COUNT(*) as count
FROM classifications 
WHERE response_category IS NOT NULL
GROUP BY response_category, response_subcategory, response_urgency, requires_expertise
ORDER BY response_category, count DESC;