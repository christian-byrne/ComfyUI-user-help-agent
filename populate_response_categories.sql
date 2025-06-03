-- Populate response categories table with enhanced categorization system
INSERT OR REPLACE INTO response_categories (category, subcategory, description, response_template, expertise_level, typical_response_time) VALUES
-- needs_information (enhanced)
('needs_information', 'missing_reproduction_steps', 'Clear step-by-step reproduction needed', 'Request specific reproduction steps with workflow/settings', 'community', '< 1 hour'),
('needs_information', 'missing_system_info', 'System specs, OS, GPU info required', 'Request system specifications and environment details', 'community', '< 1 hour'),
('needs_information', 'missing_error_logs', 'Complete error logs and stack traces needed', 'Request complete error logs and console output', 'community', '< 1 hour'),
('needs_information', 'insufficient_context', 'More background/use case details required', 'Request additional context and use case details', 'community', '< 2 hours'),

-- needs_guidance (enhanced)
('needs_guidance', 'workflow_tutorial', 'Step-by-step workflow with examples', 'Provide detailed workflow tutorial with examples', 'expert', '2-4 hours'),
('needs_guidance', 'configuration_help', 'Settings and setup assistance', 'Guide through configuration and setup process', 'intermediate', '1-2 hours'),
('needs_guidance', 'installation_guide', 'Installation/setup instructions', 'Provide installation instructions for specific setup', 'intermediate', '1-2 hours'),
('needs_guidance', 'best_practices', 'Usage patterns and optimization advice', 'Share best practices and optimization tips', 'expert', '2-4 hours'),

-- needs_technical_review (refined)
('needs_technical_review', 'bug_investigation', 'Technical debugging required', 'Investigate technical issue with debugging', 'developer', '4-8 hours'),
('needs_technical_review', 'performance_analysis', 'Performance impact assessment', 'Analyze performance implications and optimization', 'developer', '4-8 hours'),
('needs_technical_review', 'feature_evaluation', 'Technical feasibility review', 'Evaluate technical feasibility and implementation approach', 'developer', '2-4 hours'),
('needs_technical_review', 'architecture_discussion', 'Design pattern evaluation', 'Discuss architectural implications and design patterns', 'architect', '4-8 hours'),
('needs_technical_review', 'already_fixed', 'Issue resolved in newer version', 'Point to resolution in newer version with details', 'community', '< 1 hour'),

-- needs_clarification (enhanced)
('needs_clarification', 'vague_feature_request', 'Requirements specification needed', 'Request detailed requirements and specifications', 'product', '1-2 hours'),
('needs_clarification', 'unclear_problem_statement', 'Problem definition required', 'Clarify the exact problem and desired outcome', 'community', '< 2 hours'),
('needs_clarification', 'scope_definition', 'Feature boundaries clarification', 'Define scope and boundaries of requested feature', 'product', '1-2 hours'),
('needs_clarification', 'use_case_validation', 'Real-world application confirmation', 'Validate real-world use cases and applications', 'product', '1-2 hours'),

-- needs_redirection (enhanced)
('needs_redirection', 'already_fixed', 'Fixed in newer version/existing solution', 'Point to existing solution or newer version', 'community', '< 30 min'),
('needs_redirection', 'wrong_repository', 'Different repo responsibility', 'Redirect to appropriate repository or maintainer', 'community', '< 30 min'),
('needs_redirection', 'community_discussion', 'Discussion forum more appropriate', 'Redirect to community discussion platforms', 'community', '< 30 min'),
('needs_redirection', 'external_dependency', 'Third-party library/tool issue', 'Redirect to external dependency maintainers', 'community', '< 1 hour'),

-- needs_troubleshooting (refined)
('needs_troubleshooting', 'configuration_error', 'Settings/config fix needed', 'Provide step-by-step configuration fix', 'intermediate', '1-2 hours'),
('needs_troubleshooting', 'dependency_issue', 'Package/environment resolution', 'Guide through dependency resolution process', 'intermediate', '1-2 hours'),
('needs_troubleshooting', 'user_mistake', 'Common error with standard fix', 'Provide standard fix for common user error', 'community', '< 1 hour'),
('needs_troubleshooting', 'environment_setup', 'Development environment issue', 'Help resolve development environment setup', 'intermediate', '1-2 hours'),

-- NEW: needs_community_engagement
('needs_community_engagement', 'feature_collaboration', 'Community input/collaboration required', 'Engage community for collaborative development', 'community', '1-2 days'),
('needs_community_engagement', 'user_showcase', 'Success story/example sharing', 'Encourage sharing of success stories and examples', 'community', '< 1 hour'),
('needs_community_engagement', 'feedback_collection', 'User experience gathering', 'Collect user feedback and experiences', 'product', '2-4 hours'),
('needs_community_engagement', 'contribution_opportunity', 'Good first issue/help wanted', 'Guide potential contributors to get involved', 'community', '1-2 hours'),

-- NEW: needs_documentation
('needs_documentation', 'api_documentation', 'API reference needed', 'Create or update API documentation', 'developer', '4-8 hours'),
('needs_documentation', 'example_workflow', 'Working example required', 'Create example workflow demonstrating feature', 'expert', '2-4 hours'),
('needs_documentation', 'migration_guide', 'Version upgrade instructions', 'Create migration guide for version changes', 'developer', '4-8 hours'),
('needs_documentation', 'troubleshooting_guide', 'Common issues documentation', 'Document common issues and resolutions', 'expert', '2-4 hours');