require 'csv'

# Read in the CSV
lines = CSV.read('Validity-Take-Home-Exercise.csv', headers: true)

def display_dup_sets(dupset)
  # take a list grouped by duplicate and display them
  setcount = 1
  dupset.each do |set|
    if set.length > 1
      puts "Duplicate Set #{setcount}:"
      set.each do |dup|
        puts "ID #{dup[0]}: #{dup[1]} #{dup[2]}, #{dup[3]}, #{dup[5]}, #{dup[8]}, #{dup[10]} #{dup[7]}, #{dup[11]}, #{dup[4]}"
      end
      puts ''
      setcount += 1
    end
  end
  puts ''
  puts ''
  puts 'Non-Duplicates'
  dupset.each do |set|
    if set.length == 1
      set.each do |dup|
        puts "ID #{dup[0]}: #{dup[1]} #{dup[2]}, #{dup[3]}, #{dup[5]}, #{dup[8]}, #{dup[10]} #{dup[7]}, #{dup[11]}, #{dup[4]}"
      end
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

# display_dup_sets(emaildupes)

# dedupe based on phone no's

phones = []

lines.each do |row|
  phones << row[11]
end

phones.uniq!

phonedupes = []

# phones.each do |phone|
#   dupephones = []
#   lines.each do |row|
#     dupephones.push row if row[11] == phone
#   end
#   phonedupes.push dupephones
# end

phones.each do |phone|
  dupephones = []
  emaildupes.each do |emaildup|
    emaildup.each do |dup|
      # p dup[11]
      # p phone
      if dup[11] == phone
        emaildup.each do |dup1|
          dupephones.push dup1
        end
        break
      end
    end
  end
  phonedupes.push(dupephones)
end

# p phonedupes
phonedupes.uniq!

display_dup_sets(phonedupes)

# p phonedupes.count
