-- ComfyUI Issue Classification Database Schema
-- Run with: sqlite3 comfyui_issues.db < init_database.sql

-- Core issues table
CREATE TABLE IF NOT EXISTS issues (
    id INTEGER PRIMARY KEY,
    number INTEGER UNIQUE,
    title TEXT,
    body TEXT,
    state TEXT,
    labels TEXT, -- JSON array as string
    author TEXT,
    created_at TEXT,
    updated_at TEXT,
    closed_at TEXT,
    raw_data TEXT, -- Full JSON response
    last_processed TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Comments for additional context
CREATE TABLE IF NOT EXISTS comments (
    id INTEGER PRIMARY KEY,
    issue_number INTEGER,
    comment_id INTEGER,
    body TEXT,
    author TEXT,
    created_at TEXT,
    raw_data TEXT,
    FOREIGN KEY (issue_number) REFERENCES issues(number)
);

-- Classification results
CREATE TABLE IF NOT EXISTS classifications (
    id INTEGER PRIMARY KEY,
    issue_number INTEGER,
    classification_type TEXT, -- 'user_error', 'feature_request_invalid', 'how_to', 'insufficient_info', 'bug_report', 'feature_request_valid', etc.
    optimal_response TEXT, -- The recommended response strategy
    confidence_score REAL, -- 0.0 to 1.0
    reasoning TEXT, -- Why this classification was chosen
    key_indicators TEXT, -- What patterns led to this classification
    similar_issues TEXT, -- JSON array of similar issue numbers
    last_updated TEXT DEFAULT CURRENT_TIMESTAMP,
    classification_version INTEGER DEFAULT 1,
    FOREIGN KEY (issue_number) REFERENCES issues(number)
);

-- Processing state tracking
CREATE TABLE IF NOT EXISTS processing_state (
    id INTEGER PRIMARY KEY,
    key TEXT UNIQUE,
    value TEXT,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Meta-learning and insights
CREATE TABLE IF NOT EXISTS meta_notes (
    id INTEGER PRIMARY KEY,
    date TEXT DEFAULT CURRENT_TIMESTAMP,
    category TEXT, -- 'pattern', 'improvement', 'insight', 'classification_refinement'
    note TEXT,
    related_issues TEXT, -- JSON array of relevant issue numbers
    confidence TEXT -- 'high', 'medium', 'low'
);

-- Pattern recognition for "how to identify" future issues
CREATE TABLE IF NOT EXISTS identification_patterns (
    id INTEGER PRIMARY KEY,
    classification_type TEXT,
    pattern_type TEXT, -- 'title_keyword', 'body_pattern', 'label_combination', 'author_pattern'
    pattern_value TEXT,
    confidence_weight REAL,
    examples TEXT, -- JSON array of issue numbers that match this pattern
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Initialize processing state
INSERT OR IGNORE INTO processing_state (key, value) VALUES 
    ('last_processed_issue', '0'),
    ('processing_direction', 'newest_first'), -- 'newest_first' or 'oldest_unprocessed'
    ('total_issues_processed', '0'),
    ('session_start_time', datetime('now')),
    ('classification_version', '1');

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_issues_number ON issues(number);
CREATE INDEX IF NOT EXISTS idx_comments_issue_number ON comments(issue_number);
CREATE INDEX IF NOT EXISTS idx_classifications_issue_number ON classifications(issue_number);
CREATE INDEX IF NOT EXISTS idx_classifications_type ON classifications(classification_type);
CREATE INDEX IF NOT EXISTS idx_processing_state_key ON processing_state(key);
CREATE INDEX IF NOT EXISTS idx_meta_notes_date ON meta_notes(date);
CREATE INDEX IF NOT EXISTS idx_meta_notes_category ON meta_notes(category);

-- Initial meta note
INSERT INTO meta_notes (category, note, confidence) VALUES 
    ('system', 'Database initialized for ComfyUI issue classification system', 'high');

-- Print confirmation
SELECT 'Database initialized successfully!' as status;
SELECT 'Tables created: ' || COUNT(*) as table_count FROM sqlite_master WHERE type='table';