#!/usr/bin/env python
#
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# Run repopick.py -h for a description of this utility.
#

from __future__ import print_function

import sys
import json
import os
import subprocess
import re
import argparse
import textwrap

try:
  # For python3
  import urllib.request
except ImportError:
  # For python2
  import imp
  import urllib2
  urllib = imp.new_module('urllib')
  urllib.request = urllib2

# Locate the repo and git binaries
repo_bin = 'repo'
git_bin = 'git'

# Parse the command line
parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=textwrap.dedent('''\
    repopick.py is a utility to simplify the process of cherry picking
    patches from CyanogenMod's Gerrit instance.

    Given a list of change numbers, repopick will cd into the project path
    and cherry pick the latest patch available.

    With the --start-branch argument, the user can specify that a branch
    should be created before cherry picking. This is useful for
    cherry-picking many patches into a common branch which can be easily
    abandoned later (good for testing other's changes.)

    The --abandon-first argument, when used in conjuction with the
    --start-branch option, will cause repopick to abandon the specified
    branch in all repos first before performing any cherry picks.'''))
parser.add_argument('change_number', nargs='+', help='change number to cherry pick')
parser.add_argument('--ignore-missing', action='store_true', help='do not error out if a patch applies to a missing directory')
parser.add_argument('--start-branch', nargs=1, help='start the specified branch before cherry picking')
parser.add_argument('--abandon-first', action='store_true', help='before cherry picking, abandon the branch specified in --start-branch')
parser.add_argument('--quiet', action='store_true', help='print as little as possible')
parser.add_argument('--verbose', action='store_true', help='print extra information to aid in debug')
args = parser.parse_args()
if args.start_branch == None and args.abandon_first:
    parser.error('if --abandon-first is set, you must also give the branch name with --start-branch')

# Simple wrapper for os.system() that exits on error and prints out the command if --verbose
def execute_cmd(cmd):
    if args.verbose:
        print('Executing: %s' % cmd)
    if os.system(cmd):
        if not args.verbose:
            print('\nCommand that failed:\n%s' % cmd)
        sys.exit(1)

# If --abandon-first is given, abandon the branch before starting
if args.abandon_first:
    if not args.quiet:
        print('Abandoning branch: %s' % args.start_branch[0])
    cmd = '%s abandon %s' % (repo_bin, args.start_branch[0])
    if args.verbose:
        print('Executing: %s' % cmd)
    os.system(cmd)   # can't use execute_cmd() here since abandon may not find anything to do which is okay
    if not args.quiet:
        print('')

# Iterate through the requested change numbers
for change in args.change_number:
    if not args.quiet:
        print('Applying change number %s ...' % change)

    # Fetch information about the change from Gerrit's REST API
    #
    # gerrit returns two lines, a magic string and then valid JSON:
    #   )]}'
    #   [ ... valid JSON ... ]
    url = 'http://review.cyanogenmod.com/changes/?q=%s&o=CURRENT_REVISION&o=CURRENT_COMMIT&pp=0' % change
    if args.verbose:
        print('Fetching from: %s\n' % url)
    f = urllib.request.urlopen(url)
    d = f.read().decode()

    # Parse the result
    if args.verbose:
        print('Result from request:\n' + d)
    d = d.split('\n')[1]
    d = re.sub(r'\[(.*)\]', r'\1', d)
    data = json.loads(d)

    # Extract information from the JSON response
    project_name     = data['project']
    change_number    = data['_number']
    current_revision = data['revisions'][data['current_revision']]
    patch_number     = current_revision['_number']
    fetch_url        = current_revision['fetch']['http']['url']
    fetch_ref        = current_revision['fetch']['http']['ref']
    author_name      = current_revision['commit']['author']['name']
    author_email     = current_revision['commit']['author']['email']
    author_date      = current_revision['commit']['author']['date']
    committer_name   = current_revision['commit']['committer']['name']
    committer_email  = current_revision['commit']['committer']['email']
    committer_date   = current_revision['commit']['committer']['date']
    subject          = current_revision['commit']['subject']

    # Get the list of projects that repo knows about
    #   - convert the project name to a project path
    plist = subprocess.Popen(["repo","list"], stdout=subprocess.PIPE)
    while(True):
        retcode = plist.poll()
        pline = plist.stdout.readline().rstrip()
        ppaths = re.split('\s*:\s*', pline.decode())
        if ppaths[1] == project_name:
            project_path = ppaths[0]
            break
        if(retcode is not None):
            break

    # Check that the project path exists
    if not os.path.isdir(project_path):
        if args.ignore_missing:
            print('WARNING: Skipping %d since there is no project directory: %s\n' % (change_number, project_path))
            continue;
        else:
            sys.stderr.write('ERROR: For %d, there is no project directory: %s' % (change_number, project_path))
            sys.exit(1)

    # If --start-branch is given, create the branch (more than once per path is okay; repo ignores gracefully)
    if args.start_branch:
        cmd = '%s start %s %s' % (repo_bin, args.start_branch[0], project_path)
        execute_cmd(cmd)

    # Print out some useful info
    if not args.quiet:
        print('--> Subject:       "%s"' % subject)
        print('--> Project path:  %s' % project_path)
        print('--> Change number: %d (Patch Set %d)' % (change_number, patch_number))
        print('--> Author:        %s <%s> %s' % (author_name, author_email, author_date))
        print('--> Committer:     %s <%s> %s' % (committer_name, committer_email, committer_date))

    # Perform the cherry-pick
    cmd = 'cd %s && git fetch %s %s && git cherry-pick FETCH_HEAD' % (project_path, fetch_url, fetch_ref)
    execute_cmd(cmd)
    if not args.quiet:
        print('')

