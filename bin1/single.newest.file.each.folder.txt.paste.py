# purpose: find single newest file in each path recursevly.
#    python, starting from current folder, find files recursively. list only the one newest modified file for each path. 
#    show the file modified timestamp, path, and filename.
# usage: cd to within the folder you want, then paste all this...

mkdir -p $HOME/bin
f=$HOME/bin/tmp991
tee $f <<- 'HEREDOC'



import os
import glob
import datetime

# Function to get the newest file in a directory
def get_newest_file(path):
    list_of_files = glob.glob(path + '/**/*', recursive=True)
    if list_of_files:
        try:
            newest_file = max(list_of_files, key=os.path.getmtime)
            modified_time = os.path.getmtime(newest_file)
            modified_time_iso = datetime.datetime.fromtimestamp(modified_time).strftime('%Y-%m-%dT%H:%M:%S')
            return modified_time_iso, path, os.path.basename(newest_file)
        except FileNotFoundError as e:
            print(f"Error accessing file: {e}")
        except PermissionError as e:
            print(f"Permission denied: {e}")
    else:
        print(f"No files found in {path}")

# Main function to find newest files recursively
def find_newest_files(starting_folder):
    files_info = []
    for root, dirs, files in os.walk(starting_folder):
        if all(folder_name not in ['x', 'tmp', 'log', '.git'] for folder_name in root.split(os.path.sep)):
            if files:
                try:
                    newest_file_info = get_newest_file(root)
                    if newest_file_info:
                        files_info.append(newest_file_info)
                except PermissionError as e:
                    print(f"Permission denied: {e}")

    files_info.sort(key=lambda x: x[0])  # Sort by timestamp
    for info in files_info:
        print(f"  {info[0]}, {info[1]}/{info[2]}")

# Example usage
find_newest_files('.')



HEREDOC
python3 $f

        # print(f"{info[0]},\t  {info[1]}/{info[2]}")

