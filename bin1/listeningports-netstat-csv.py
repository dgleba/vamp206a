
# Given netstat -ptunl output like the following, 
# create python script to convert it to csv
# split the 4th column into two columns by the last colon and call that column eport,
# then, sort the csv numerically by eport,
# wrap the python in a bash heredoc and write that to a file called lports.py

# Active Internet connections (servers and established)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
# tcp        0      0 127.0.0.1:27001         0.0.0.0:*               LISTEN      3268/storagegui    
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      947/sshd: /usr/sbin
# tcp        0      0 192.168.88.103:40000    0.0.0.0:*               LISTEN      4405/python3
# tcp        0      0 0.0.0.0:21119           0.0.0.0:*               LISTEN      4050/docker-proxy
# tcp        0      0 192.168.88.103:47734    176.9.109.126:443       ESTABLISHED 3475/storagesync
# tcp6       0      0 ::1:631                 :::*                    LISTEN      221974/cupsd
# tcp6       0      0 :::22                   :::*                    LISTEN      947/sshd: /usr/sbin
# tcp6       0      0 fe80::abd3:9a1e:8:40000 :::*                    LISTEN      4405/python3
# udp        0      0 192.168.88.103:68       192.168.88.1:67         ESTABLISHED 789/NetworkManager
# udp        0      0 0.0.0.0:21119           0.0.0.0:*                           2756023/rustdesk
# udp6       0      0 fe80::abd3:9a1e:88:5353 :::*                                4405/python3



# =================================================

# Answer..


# usage:

# sudo apt install net-tools

# paste the  program heredoc into terminal to write the program to disk.

# cd
# mkdir -p 0
# cd 0
# sudo netstat -apnl | python3 lports.py - 


# or

# sudo netstat -aptunl | python3 lports.py - 

# python3 lports.py netstat_output.txt --output_csv=o4.csv --unique_csv=o5.csv





# =================================================



cd ; mkdir -p 0 ; cd 0;

# heredoc...

cat << 'EOF' > lports.py
import csv
import sys
import argparse

def parse_netstat_line(line):
    """
    Parse a single line of netstat output and return a dictionary with the relevant fields.
    """
    parts = line.split(None, 6)  # Split into up to 7 parts
    if len(parts) < 5:
        return None  # Not enough parts to parse
    
    proto = parts[0]
    recv_q = parts[1]
    send_q = parts[2]
    local_address = parts[3]
    foreign_address = parts[4]
    
    if proto.startswith('tcp'):
        if len(parts) >= 7:
            state, pid_program = parts[5], parts[6]
        elif len(parts) == 6:
            state = ''
            pid_program = parts[5]
        else:
            return None
    else:
        state = ''
        if len(parts) >= 6:
            pid_program = parts[5]
        else:
            pid_program = ''
    
    if ':' in local_address:
        local_ip, eport = local_address.rsplit(':', 1)
    else:
        local_ip, eport = local_address, ''
    
    try:
        eport_int = int(eport)
    except ValueError:
        eport_int = -1  # Assign a default value for non-integer ports
    
    return {
        'Proto': proto,
        'Recv-Q': recv_q,
        'Send-Q': send_q,
        'Local IP': local_ip,
        'eport': eport_int,
        'Foreign Address': foreign_address,
        'State': state,
        'PID/Program name': pid_program
    }

'''
def justify_columns_fstring (records, headers):
    # Get the max width for each column
    col_widths = {header: len(header) for header in headers}
    
    for record in records:
        for header in headers:
            col_widths[header] = max(col_widths[header], len(str(record[header])))
    
    # Print headers with justified columns
    header_row = "  ".join(f"{header:<{col_widths[header]}}" for header in headers)
    print(header_row)
    print("-" * len(header_row))  # Divider

    # Print each row with justified columns
    for record in records:
        row = "  ".join(f"{str(record[header]):<{col_widths[header]}}" for header in headers)
        print(row)
'''

def justify_columns(records, headers):
    """
    Print the records with justified columns based on the maximum width of each column.
    """
    # Calculate maximum width for each column
    col_widths = {header: len(header) for header in headers}

    for record in records:
        for header in headers:
            col_widths[header] = max(col_widths[header], len(str(record[header])))

    # Create the header row with justified columns using str.format()
    header_row = "  ".join("{:<{width}}".format(header, width=col_widths[header]) for header in headers)
    print(header_row)
    
    # Create a divider based on the header row length
    print("-" * len(header_row))  # Divider

    # Print each record with justified columns
    for record in records:
        row = "  ".join("{:<{width}}".format(str(record[header]), width=col_widths[header]) for header in headers)
        print(row)
        

def main():
    parser = argparse.ArgumentParser(description='Convert netstat output to CSV.')
    parser.add_argument('input_file', nargs='?', type=argparse.FileType('r'), default=sys.stdin,
                        help='Input file containing netstat output. Defaults to stdin.')
    parser.add_argument('--output_csv', nargs='?', type=argparse.FileType('w'), default='output.csv',
                        help='Output CSV file. Defaults to output.csv.')
    parser.add_argument('--unique_csv', nargs='?', type=argparse.FileType('w'), default='o5.csv',
                        help='Output CSV file with unique eport entries. Defaults to o5.csv.')
    args = parser.parse_args()
    
    records = []
    
    # Read all lines from the input
    lines = args.input_file.readlines()
    
    # Skip the header lines (first two lines)
    data_lines = lines[2:]
    
    for line in data_lines:
        line = line.strip()
        if not line:
            continue  # Skip empty lines
        record = parse_netstat_line(line)
        if record:
            records.append(record)
    
    # Sort the records by 'eport' numerically
    sorted_records = sorted(records, key=lambda x: x['eport'])
    
    # Define CSV headers
    headers = ['Proto', 'Recv-Q', 'Send-Q', 'Local IP', 'eport', 'Foreign Address', 'State', 'PID/Program name']
    
    # Write to output.csv
    with args.output_csv as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=headers)
        writer.writeheader()
        for rec in sorted_records:
            rec['eport'] = str(rec['eport']) if rec['eport'] != -1 else ''
            writer.writerow(rec)
    
    # print(f"CSV has been written to {args.output_csv.name}")
    print("CSV has been written to {args.output_csv.name}")
        
    # Eliminate duplicates: keep only the first occurrence of each eport
    unique_eport_records = []
    seen_eports = set()
    
    for rec in sorted_records:
        if rec['eport'] not in seen_eports:
            unique_eport_records.append(rec)
            seen_eports.add(rec['eport'])
    
    # Write the unique eport records to o5.csv
    with args.unique_csv as unique_csvfile:
        writer = csv.DictWriter(unique_csvfile, fieldnames=headers)
        writer.writeheader()
        for rec in unique_eport_records:
            rec['eport'] = str(rec['eport']) if rec['eport'] != -1 else ''
            writer.writerow(rec)
    
    print("CSV with unique eport has been written to {args.unique_csv.name}")
    print("printing {args.unique_csv.name} for your convienence..")

    # Print the output with justified columns
    justify_columns(unique_eport_records, headers)


if __name__ == "__main__":
        main()
EOF


cd ; mkdir -p 0 ; cd 0;
sudo netstat -aptunl | python3 lports.py - 

#

cat output.csv | column -t -s,
echo -e " \n\n----   unique ports listing:  ----- \n"
cat o5.csv | column -t -s,


# =================================================



