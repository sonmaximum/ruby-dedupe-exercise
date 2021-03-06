require 'csv'
require 'levenshtein'

def display_dup_sets(dupset)
  # take a list grouped by duplicates and display them
  setcount = 1
  dupset.each do |set|
    if set.length > 1
      puts "Duplicate Set #{setcount}:"
      set.each do |dup|
        # displays "ID #: FirstName LastName, Company, Address, City, State, Zip, PhoneNo., Email"
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

def email_phone_solution
  # Read in the CSV
  lines = CSV.read(ARGV[0], headers: true)

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

  # dedupe based on phone no's

  phones = []

  lines.each do |row|
    phones << row[11]
  end

  phones.uniq!

  phonedupes = []

  # if deduping only on phones:
  # phones.each do |phone|
  #   dupephones = []
  #   lines.each do |row|
  #     dupephones.push row if row[11] == phone
  #   end
  #   phonedupes.push dupephones
  # end

  # double de-dup on phone after email
  phones.each do |phone|
    dupephones = []
    emaildupes.each do |emaildup|
      emaildup.each do |dup|
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

  phonedupes.uniq!

  display_dup_sets(phonedupes)
end

def levenshtein_solution
  lines = CSV.read(ARGV[0], headers: true)
  names = []

  lines.each do |row|
    names << "#{row[1]} #{row[2]}"
  end

  namedupes = []

  names.each do |name|
    dupenames = []
    lines.each do |row|
      dupenames.push row if Levenshtein.distance "#{row[1]} #{row[2]}", name, 5
    end
    namedupes.push dupenames
  end

  namedupes.uniq!

  display_dup_sets(namedupes)
end

if ARGV[1] == 'lev'
  levenshtein_solution
else
  email_phone_solution
end
