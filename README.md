# ADA-PhoneBook
A simple phone book implementation in ada.

Application:

The program is a Phone Book application written using ADA and SPARK. The program is user interactive and performs typical actions required in a Phone Book application such as adding, deleting, searching and displaying contacts. There is also a feature where it provides timing statistics of the Phone Book application.


Interface:

Program dynamically asks the user for the actions to perform and displays the options accordingly. When the program expects the user to choose from the available options, it specifically expects INTEGER INPUTS. In other cases where strings are to be entered, max size of strings are displayed.

Depending on the user choices, the application performs the following actions.
1) Add: Adds a new contact to the Phone Book. Maximum number of contacts is set to 10 using MAX_NO_CONTACTS.
2) Delete: Asks for the entry no. of the contact and deletes it from the Phone Book.
3) Search: Searches for a given First name or Last name in full.
4) Time Stats: Displays the run time of the application and the time since Phone Book was last modified.
5) Display: Displays the current Phone Book.
6) Quit: Exits the application.


Features used:

• Packages: Separate packages to manage contacts, update time statistics and one separate package for SPARK.
• Procedures, functions, attributes, user types and loops used throughout the program.
• Generics: Used in contact_mgr.adb through Contact_Book_Full function.
• Protected Object: ContactCountObj is used to protectively maintain contact count in the Phone Book.
• Task: Used to update timing statistics in time_mgr package.
• Access Type: Used to access the contact count inside ContactCountObj.
• Real Time Annex: Used to maintain timing statistics of the Phone Book.
• SPARK: Precondition, Postcondition, Pragma Assert and Proof of AoRTE are used in the search package. The SPARK report file gnatprove.out is submitted for reference.
• Global and Depends have also been used in search package.
