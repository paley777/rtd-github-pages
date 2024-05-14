#!/bin/bash
set -x

################################################################################
# File:    buildDocs.sh
# Purpose: Script that builds our documentation using Sphinx and updates GitHub
#          Pages. This script is executed by GitHub Actions.
#
# Authors: [Your Name]
# Created: [Date]
# Updated: [Date]
# Version: 1.0
################################################################################

###################
# INSTALL DEPENDS #
###################

# Update package list and install required packages
apt-get update
apt-get -y install git rsync python3-sphinx python3-sphinx-rtd-theme

#####################
# DECLARE VARIABLES #
#####################

# Set current directory as the root of the repository
cd $GITHUB_WORKSPACE

# Set environment variable for source date epoch
export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)

##############
# BUILD DOCS #
##############

# Change directory to the docs folder
cd docs

# Clean previous builds
make clean

# Build HTML documentation
make html

#######################
# UPDATE GITHUB PAGES #
#######################

# Create temporary directory for generated docs
docroot=$(mktemp -d)

# Copy generated HTML docs to temporary directory
rsync -av "docs/_build/html/" "${docroot}/"

# Configure git
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

# Switch to temporary directory
cd "${docroot}"

# Initialize git repository
git init
git remote add deploy "https://token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git checkout -b gh-pages

# Add .nojekyll file
touch .nojekyll

# Add README.md
cat > README.md <<EOF
# GitHub Pages Cache

Nothing to see here. The contents of this branch are essentially a cache that's not intended to be viewed on github.com.

If you're looking to update our documentation, check the relevant development branch's 'docs/' directory.

For more information on how this documentation is built using Sphinx, Read the Docs, and GitHub Actions/Pages, see:

 * [Link to documentation setup guide]
EOF

# Add, commit, and push changes
git add .
git commit -m "Updating Docs for commit ${GITHUB_SHA} made on $(date -d"@${SOURCE_DATE_EPOCH}" --iso-8601=seconds) from ${GITHUB_REF} by ${GITHUB_ACTOR}"
git push deploy gh-pages --force

# Clean up temporary directory
cd ..
rm -rf "${docroot}"

# Return to the root of the repository
cd $GITHUB_WORKSPACE

# Exit cleanly
exit 0
