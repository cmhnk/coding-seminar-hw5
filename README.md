# Assignment:

##User Validator

## Description

Write a Ruby class which will parse a CSV file of new users and validate that they have the correct information.

## Objectives

After completing this assignment, you should...

* Be able to read from a CSV file
* Be able to validate data with regular expressions

## Deliverables

* **A GitHub repository.**
* **A series of commits on that repository.**  Not just one at the end!
* **A test suite.**  All public methods should be tested.

After your work is complete, make sure to `git push` your changes up to GitHub.  Feel free to do this more than once along the way, of course.

## Normal Mode

Your clients are organizations with many users.  Because they don't want to bother with things like invitations to each person, they would like to give you a spreadsheet in CSV format with all necessary user information.  Your task as a developer is to pre-process the spreadsheet and report back on whether the information is valid.

You should write a Ruby class which:

* Instantiates with a string which is the path to the CSV file on disk.
* Reviews all the data in the CSV file, and then `puts` back a description of the lines which were invalid.
* If the `joined` field does not contain a valid date, it should be reported.
* If the `email` field does not contain a valid email address, it should be reported.
* If the `phone` field does not contain a valid phone number, it should be reported.
* The program should report a count of how many lines were valid, then report the line numbers of lines which were invalid, as well as which fields were invalid for each.
* All of this reporting should be done at the end of the review process, not by `puts`ing all along the way.
* This code should be written with small validation methods inside it which are tested!

Use the [homework.csv](homework.csv) file as an example dataset.

## Hard Mode

Hard mode has two additional requirements:

First, extend your code so that the columns can be given in any order.  The column names must match the names given in the example file, just not necessarily in the same order.

Second, add a `password` validation to the review process.  Passwords should only be valid if they have 6 or more characters, and if they have three or more of the following:

* lowercase letters
* uppercase letters
* numbers
* special characters

## Nightmare Mode

Report on the phone numbers and dates which DO match the regular expression.  However, standardize the information after detecting it.

When you report phone numbers, you must display them in the format `(xxx) xxx-xxxx`.  In other words, if someone has a phone number of `919.555.9876`, your code should `puts` `(919) 555-9876`.

When you report dates, you must display them in the format `2017-02-01`.

## Additional Resources

* [Rubular](http://www.rubular.com/)
* For more practice: [RegexOne](https://regexone.com/)
* Docs on Ruby CSV: [CSV](https://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html)
