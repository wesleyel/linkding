#!/bin/bash
set -euo pipefail

npm ci
npm run build

# Create data folder if it does not exist
mkdir -p data
# Create favicon folder if it does not exist
mkdir -p data/favicons
# Create previews folder if it does not exist
mkdir -p data/previews
# Create assets folder if it does not exist
mkdir -p data/assets

# create a virtual environment named 'venv' if it doesn't already exist
python3.12 -m venv venv
# activate the virtual environment
source venv/bin/activate
# install the dependencies
pip install -r requirements.txt
# generate a secret key
python3.12 manage.py generate_secret_key
# Run database migration
python3.12 manage.py migrate
# Create initial superuser if defined in options / environment variables
python3.12 manage.py create_initial_superuser
# # Migrate legacy background tasks to Huey. Not supported with postgres.
# python3.12 manage.py migrate_tasks
# collect static files
python3.12 manage.py collectstatic --no-input --clear
