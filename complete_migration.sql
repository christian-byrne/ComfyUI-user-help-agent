-- Complete the migration by filling in missing expertise and response time data

-- Update expertise requirements based on category and subcategory
UPDATE classifications SET requires_expertise = 
    CASE 
        WHEN response_category = 'needs_information' THEN 'community'
        WHEN response_category = 'needs_guidance' AND response_subcategory IN ('workflow_tutorial', 'best_practices') THEN 'expert'
        WHEN response_category = 'needs_guidance' THEN 'intermediate'
        WHEN response_category = 'needs_technical_review' AND response_subcategory = 'architecture_discussion' THEN 'architect'
        WHEN response_category = 'needs_technical_review' THEN 'developer'
        WHEN response_category = 'needs_clarification' AND response_subcategory LIKE '%feature%' THEN 'product'
        WHEN response_category = 'needs_clarification' THEN 'community'
        WHEN response_category = 'needs_redirection' THEN 'community'
        WHEN response_category = 'needs_troubleshooting' THEN 'intermediate'
        WHEN response_category = 'needs_community_engagement' THEN 'community'
        WHEN response_category = 'needs_documentation' THEN 'developer'
        ELSE 'community'
    END
WHERE requires_expertise IS NULL OR requires_expertise = '';

-- Update estimated response times based on urgency and complexity
UPDATE classifications SET estimated_response_time = 
    CASE 
        WHEN response_category = 'needs_redirection' THEN '< 1 hour'
        WHEN response_urgency = 'high' AND response_category = 'needs_information' THEN '< 1 hour'
        WHEN response_urgency = 'high' THEN '2-4 hours'
        WHEN response_category = 'needs_information' THEN '< 2 hours'
        WHEN response_category = 'needs_guidance' AND requires_expertise = 'expert' THEN '2-4 hours'
        WHEN response_category = 'needs_guidance' THEN '1-2 hours'
        WHEN response_category = 'needs_technical_review' AND requires_expertise = 'architect' THEN '4-8 hours'
        WHEN response_category = 'needs_technical_review' THEN '2-4 hours'
        WHEN response_category = 'needs_clarification' THEN '1-2 hours'
        WHEN response_category = 'needs_troubleshooting' THEN '1-2 hours'
        WHEN response_category = 'needs_community_engagement' THEN '1-2 days'
        WHEN response_category = 'needs_documentation' THEN '4-8 hours'
        ELSE '1-2 hours'
    END
WHERE estimated_response_time IS NULL OR estimated_response_time = '';

-- Generate final summary report
SELECT 
    'Final Migration Report' as status,
    COUNT(*) as total_records,
    COUNT(CASE WHEN response_category IS NOT NULL THEN 1 END) as categorized,
    COUNT(CASE WHEN response_strategy IS NOT NULL THEN 1 END) as strategy_assigned,
    COUNT(CASE WHEN requires_expertise IS NOT NULL THEN 1 END) as expertise_assigned,
    COUNT(CASE WHEN estimated_response_time IS NOT NULL THEN 1 END) as time_estimated,
    ROUND(COUNT(CASE WHEN response_category IS NOT NULL THEN 1 END) * 100.0 / COUNT(*), 1) as completion_percentage
FROM classifications;