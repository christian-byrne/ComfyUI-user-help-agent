-- Fix missing classification_type fields based on response_category and response_subcategory
-- Map response categories to appropriate classification types

-- needs_technical_review -> bug_report or feature_request depending on subcategory
UPDATE classifications 
SET classification_type = CASE 
    WHEN response_subcategory IN ('bug_investigation') THEN 'bug_report'
    WHEN response_subcategory IN ('feature_evaluation', 'architecture_discussion') THEN 'feature_request'
    ELSE 'technical_bug'
END
WHERE (classification_type IS NULL OR classification_type = '') 
AND response_category = 'needs_technical_review';

-- needs_clarification -> feature_request or insufficient_info depending on subcategory
UPDATE classifications 
SET classification_type = CASE 
    WHEN response_subcategory IN ('vague_feature_request', 'unclear_problem_statement', 'use_case_validation') THEN 'feature_request'
    ELSE 'insufficient_info'
END
WHERE (classification_type IS NULL OR classification_type = '') 
AND response_category = 'needs_clarification';

-- needs_redirection -> resolved or feature_request depending on subcategory
UPDATE classifications 
SET classification_type = CASE 
    WHEN response_subcategory IN ('already_resolved') THEN 'resolved_feature_request'
    ELSE 'feature_request_invalid'
END
WHERE (classification_type IS NULL OR classification_type = '') 
AND response_category = 'needs_redirection';

-- needs_guidance -> how_to
UPDATE classifications 
SET classification_type = 'how_to'
WHERE (classification_type IS NULL OR classification_type = '') 
AND response_category = 'needs_guidance';

-- needs_information -> insufficient_info
UPDATE classifications 
SET classification_type = 'insufficient_info'
WHERE (classification_type IS NULL OR classification_type = '') 
AND response_category = 'needs_information';

-- needs_troubleshooting -> user_error or technical_bug depending on subcategory
UPDATE classifications 
SET classification_type = CASE 
    WHEN response_subcategory IN ('configuration_error', 'user_mistake') THEN 'user_error'
    WHEN response_subcategory IN ('dependency_issue') THEN 'technical_bug'
    ELSE 'user_error'
END
WHERE (classification_type IS NULL OR classification_type = '') 
AND response_category = 'needs_troubleshooting';

-- Add a timestamp for when these were fixed
UPDATE classifications 
SET last_updated = CURRENT_TIMESTAMP
WHERE classification_type IN ('bug_report', 'feature_request', 'technical_bug', 'insufficient_info', 
                             'resolved_feature_request', 'feature_request_invalid', 'how_to', 'user_error')
AND (id BETWEEN 80 AND 99 OR issue_number IN (7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26,27));