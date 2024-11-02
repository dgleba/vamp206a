
# output md5sums to file recursively 

#    python ~/bin/md5r.py . md5out.txt

#    python ~/bin/md5r.py [folder-to-md5] outputfile-md5out.txt


import hashlib
import os

def md5sum(filename):
    """Compute the MD5 sum of the given file."""
    hash_md5 = hashlib.md5()
    with open(filename, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

def write_md5sums_to_file(directory, output_file):
    """Compute MD5 sums of files in the given directory recursively and write to an output text file."""
    with open(output_file, 'w') as f:
        for root, _, files in os.walk(directory):
            for file in files:
                file_path = os.path.join(root, file)
                md5 = md5sum(file_path)
                f.write(f"{md5}  {file_path}\n")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Compute MD5 sums of files in a directory recursively.")
    parser.add_argument("directory", help="The directory to scan for files.")
    parser.add_argument("output_file", help="The file to write the MD5 sums to.")
    args = parser.parse_args()

    write_md5sums_to_file(args.directory, args.output_file)
    
