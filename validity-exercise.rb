require 'csv'

# Read in the CSV
lines = CSV.read('Validity-Take-Home-Exercise.csv', headers: true)

def display_dup_sets(dupset)
  # take a list grouped by duplicate and display them
  dupset.each do |set|
    p 'Dup set'
    set.each do |dup|
      print dup
    end
  end
end

# dedupe based on emails

emails = []

lines.each do |row|
  emails << row[4]
end

emails.uniq!

emaildupes = []

emails.each do |email|
  dupemails = []
  lines.each do |row|
    dupemails.push row if row[4] == email
  end
  emaildupes.push dupemails
end

display_dup_sets(emaildupes)

# dedupe based on phone no's

phones = []

lines.each do |row|
  phones << row[11]
end

phones.uniq!

phonedupes = []

phones.each do |phone|
  dupephones = []
  lines.each do |row|
    dupephones.push row if row[11] == phone
  end
  phonedupes.push dupephones
end

display_dup_sets(phonedupes)