.PHONY: help db-init db-reset sql-transform sql-checks psql load-checkpoint

help:
	@echo "Commands:"
	@echo "  make db-init        - create schemas/tables and seed dim_month"
	@echo "  make db-reset       - drop schemas and recreate"
	@echo "  make sql-transform  - run sql/01_transform.sql"
	@echo "  make sql-checks     - run sql/02_checks.sql"
	@echo "  make psql           - open interactive psql in the container"
	@echo "  make load-checkpoint - load pre-parsed data (if Python isn't working)"

db-init:
	docker exec -i de_assessment_pg psql -U postgres -d postgres < sql/00_schema.sql

db-reset:
	docker exec -i de_assessment_pg psql -U postgres -d postgres -c "DROP SCHEMA IF EXISTS analytics CASCADE; DROP SCHEMA IF EXISTS raw CASCADE;"
	docker exec -i de_assessment_pg psql -U postgres -d postgres < sql/00_schema.sql

sql-transform:
	docker exec -i de_assessment_pg psql -U postgres -d postgres < sql/01_transform.sql

sql-checks:
	docker exec -i de_assessment_pg psql -U postgres -d postgres < sql/02_checks.sql

psql:
	docker exec -it de_assessment_pg psql -U postgres -d postgres

load-checkpoint:
	docker exec -i de_assessment_pg psql -U postgres -d postgres < data/checkpoint/raw_data.sql
