#!/usr/bin/env python3

"""
usage:
    prfiles.py [--all] [folder1 folder2 ...]

examples:
    prfiles.py --all > ../pr.out
    prfiles.py apps utils > ../pr.out

goal:
    Print out all .py and .html files from the current directory (.)
    and recursively from either:
      - all subfolders (if --all is given), OR
      - only the listed folders.
    Each file is printed with a header showing path, filename,
    and modification timestamp, sorted by path/name.
"""

import os
import sys
import datetime

def collect_files(root=".", exts=(".py", ".html")):
    files = []
    # Only top-level files with given extensions
    for fname in os.listdir(root):
        fpath = os.path.join(root, fname)
        if fname.endswith(exts) and os.path.isfile(fpath):
            files.append((fpath, fname))
    return files

def recurse_files(folder, exts=(".py", ".html")):
    files = []
    for dirpath, _, filenames in os.walk(folder):
        for fname in filenames:
            if fname.endswith(exts):
                fpath = os.path.join(dirpath, fname)
                files.append((fpath, fname))
    return files

def print_files(folders, all_mode=False, exts=(".py", ".html")):
    files = []
    # Always include . (non-recursive)
    files.extend(collect_files(".", exts))

    if all_mode:
        # Recurse into every subfolder under .
        for entry in os.listdir("."):
            fpath = os.path.join(".", entry)
            if os.path.isdir(fpath):
                files.extend(recurse_files(fpath, exts))
    else:
        # Recurse only into listed folders
        for folder in folders:
            if os.path.isdir(folder):
                files.extend(recurse_files(folder, exts))
            else:
                print(f"Warning: {folder} is not a directory")

    # Sort by full path, then filename
    files.sort(key=lambda x: (x[0], x[1]))

    # Print each file with header
    for fpath, fname in files:
        try:
            stat = os.stat(fpath)
            mod_time = datetime.datetime.fromtimestamp(stat.st_mtime)
            header = (
                f"{'='*88}\n"
                f"###  file: {fpath}  |  Mod: {mod_time.isoformat()}\n"
            )
            print(header)
            with open(fpath, "r", encoding="utf-8", errors="replace") as f:
                print(f.read())
                print("\n")  # spacing between files
        except Exception as e:
            print(f"Could not read {fpath}: {e}")

if __name__ == "__main__":
    args = sys.argv[1:]
    all_mode = False
    folders = []

    if "--all" in args:
        all_mode = True
        folders = [arg for arg in args if arg != "--all"]
    else:
        folders = args

    print_files(folders, all_mode)

