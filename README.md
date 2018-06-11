# Max's Simple Deduplication Script

## To Run Script:

```
git clone git@github.com:sonmaximum/ruby-dedupe-exercise.git
cd ruby-dedupe-exercise/
bundle install
ruby validity-exercise.rb Validity-Take-Home-Exercise.csv lev
```

The goal of this exercise was to write a script in ruby to identify potential duplicates in a CSV file.

My first solution makes use of the fact that both phone numbers and email addresses should be unique to a user, and it's somewhat unlikely that a user would make a typo in both fields.  So it checks for uniqueness in these two columns, sequentially.

After the inital solution, I wanted to devise a solution that made use of the [levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance) between names, both to account for typos and possible alternate name spellings.  This solution checks first and last names together, and calls anything with a Levenshtein distance of less than 5 a duplicate.

The command to run the script is `ruby validity-exercise.rb [path to CSV file] [lev option]`
The path to CSV is relative to the validity-exercise.rb file, and the lev option determines which of the who solutions is used.  Entering letters "lev" uses the levenshtein solution, while anything else (or nothing) uses the initial phone/email solution.

Future developments:  The code isn't very elegant or efficient, so continuing development would likely be focused in those areas.  Additionally, the levenshtein threshhold may need to be considered more carefully (for example, the current threshhold would not match Bob vs Robert).