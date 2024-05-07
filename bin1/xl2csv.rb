#
# ruby ... https://github.com/roo-rb/roo
#   gem install roo
#
#   usage:  roo1.rb ./eam.xlsx > eam-roo.csv
#
# ref:
# python..  https://github.com/dilshod/xlsx2csv
#  sudo pip install xlsx2csv
#  xlsx2csv eam.xlsx
#

require 'roo'

# Open excel file from first argument given to the program..
xl = Roo::Spreadsheet.open(ARGV[0])

# xl.info
# xl.sheets
# xl.sheet('Sheet1').row(1)

# write csv to std out..
puts xl.to_csv


