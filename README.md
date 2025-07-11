# Legacy BL Demurrage Mini-Service

A Rails service for generating demurrage invoices for overdue bills of lading in shipping operations.

## Setup

### Prerequisites
- Ruby 3.x
- Rails 7.x (API only)
- MySQL 5.7+

### Option 1: Local Setup
```bash
git clone https://github.com/EfeAgare/legacy_bl_demurrage.git
cd legacy_bl_demurrage

# Edit config/database.yml with your MySQL credentials
bin/setup

```

The setup script will:
1. Create the database
2. Run migrations
3. Seed sample data
4. Start the server

## Running the Application
```bash
rails server
```

## Testing
Run the test suite with:
```bash
bundle exec rspec
```

## API Endpoints

### Generate Invoices
```bash
curl -X POST http://localhost:3000//api/v1/bill_of_ladings/id/generate_invoice
```

## Sample Data
The database is seeded with:
- 10 customers
- 20 bills of lading (some overdue)
- Sample invoices and refund requests

## Design Decisions

### Schema Transformation
1. Renamed French table/column names to English equivalents
2. Standardized primary keys to `id` across all tables
3. Added proper foreign key constraints missing in legacy schema
4. Maintained compatibility with legacy data structure (test_schema.sql)

### Business Logic
1. Flat rate of $80/container/day for demurrage
2. Invoices generated only for BLs overdue as of today
3. Skips BLs with existing open invoices
4. Simple status tracking (open/paid/cancelled)

### Technical Choices
1. Service object pattern for invoice generation
2. Use of active_interaction gem to keep
	•	Keeps controller logic clean
	•	Business rules live in one place
	•	Easily testable in isolation
3. Scopes for querying overdue BLs efficiently
4. JSON-only API — no views, no PDFs, no downloads

### Assumptions
1. All containers are charged at the same rate
2. Currency handling is simplified (USD only)
3. No authentication for this demo version
4. Invoice generation is triggered manually currently
5. Freetime is calculated in whole days
6. View — List of overdue invoices (no pdf, no downloads, just a table)

## Future Improvements
1. Add background job processing
2. Implement currency conversion
3. Add PDF invoice generation
4. Include authentication
5. Add more detailed reporting
