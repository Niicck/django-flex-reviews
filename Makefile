SHELL := /bin/bash
-include .env

.PHONY: install
install:
	poetry --with dev

# Start venv
.PHONY: venv
venv:
	source "$(poetry env info --path)/bin/activate"

# Lint all files using pre-commit
.PHONY: lint
lint:
	nox -s lint

# Scan dependencies for insecure packages
.PHONY: safety
safety:
	nox -s safety

# Run mypy type checking for python files.
.PHONY: mypy
mypy:
	nox -s mypy-3.11

# Run typescript type checking for typescript files.
.PHONY: tsc-check
tsc-check:
	npx tsc --noEmit --incremental

# Create .env from template if .env doesn't already exist
.env:
	cp -n ./tools/.env-sample .env

# Run django app
.PHONY: up
up:
	poetry run python manage.py runserver

# Run django app with debugger enabled
.PHONY: debug-up
debug-up:
	poetry run python -m debugpy --listen localhost:5678 --wait-for-client manage.py runserver

# Run vite static asset compilation
.PHONY: vite
vite:
	npm run dev

# Start django python shell
.PHONY: shell
shell:
	poetry run python manage.py shell

# Start debugable python shell.
.PHONY: debug-shell
debug-shell:
	poetry run python -m debugpy --listen localhost:5678 manage.py shell

# Create a superuser for your django app
.PHONY: superuser
superuser:
	poetry run python manage.py createsuperuser

# Run pytest
.PHONY: pytest
pytest:
	poetry run pytest

# Run pytest with debugger
.PHONY: debug-pytest
debug-pytest:
	poetry run python -m debugpy --listen localhost:5678 --wait-for-client -m pytest
