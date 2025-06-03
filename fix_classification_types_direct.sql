-- Direct fixes for missing classification_type fields
-- Based on response_category and response_subcategory mapping

-- Fix needs_technical_review records
UPDATE classifications SET classification_type = 'feature_request' WHERE id = 81; -- feature_evaluation
UPDATE classifications SET classification_type = 'feature_request' WHERE id = 82; -- architecture_discussion 
UPDATE classifications SET classification_type = 'bug_report' WHERE id = 84; -- bug_investigation
UPDATE classifications SET classification_type = 'feature_request' WHERE id = 87; -- feature_evaluation
UPDATE classifications SET classification_type = 'feature_request' WHERE id = 90; -- feature_evaluation
UPDATE classifications SET classification_type = 'feature_request' WHERE id = 91; -- feature_evaluation
UPDATE classifications SET classification_type = 'bug_report' WHERE id = 94; -- bug_investigation
UPDATE classifications SET classification_type = 'bug_report' WHERE id = 98; -- bug_investigation
UPDATE classifications SET classification_type = 'feature_request' WHERE id = 99; -- feature_evaluation

-- Fix needs_clarification records
UPDATE classifications SET classification_type = 'feature_request' WHERE id = 83; -- vague_feature_request
UPDATE classifications SET classification_type = 'insufficient_info' WHERE id = 86; -- unclear_problem_statement
UPDATE classifications SET classification_type = 'insufficient_info' WHERE id = 89; -- unclear_problem_statement
UPDATE classifications SET classification_type = 'feature_request' WHERE id = 93; -- use_case_validation
UPDATE classifications SET classification_type = 'feature_request' WHERE id = 96; -- vague_feature_request

-- Fix needs_redirection records
UPDATE classifications SET classification_type = 'resolved_feature_request' WHERE id = 85; -- already_resolved

-- Fix needs_guidance records
UPDATE classifications SET classification_type = 'how_to' WHERE id = 88; -- configuration_help
UPDATE classifications SET classification_type = 'how_to' WHERE id = 95; -- installation_guide

-- Fix needs_information records
UPDATE classifications SET classification_type = 'insufficient_info' WHERE id = 92; -- missing_error_logs

-- Fix needs_troubleshooting records
UPDATE classifications SET classification_type = 'user_error' WHERE id = 97; -- configuration_error

-- Update timestamps for all fixed records
UPDATE classifications SET last_updated = CURRENT_TIMESTAMP WHERE id BETWEEN 80 AND 99;