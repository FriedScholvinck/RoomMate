# Process Book

## day 1
* finished project proposal
* set up project in Xcode
* set up Google FireBase for user accounts

## day 2
* finished design document
* decided to create two keys in database: 'users' and 'houses'

## day 3
* decided to use Google Firebas Authetication, but not the database
  * database on local server (same as with Trivia Highscores)

## day 4
* finished prototype
* users can create a house with a password - other users can then select that house in a picker and join when password is correct
* added 'profile' tab
* remember user has logged in on device + possibility to log out

## day 5
* tried sample data on local server and Firebase, both worked to some extent

## day 6
* decided to not use Firebase database, but local server since data can be saved
* local database doens't yet allow for changing the data at a specific location, so I implemented things without working with actual data

## day 7
* added functionality and extra view to drink-view
* added functionality to Create House and Join House
* database doesn't yet allow for filtering on something other than predefined id's
* grouping users in houses and making houses with residents is not possible using a list within the database structure (same as in Firebase) -> solution needed

## day 8
* Decided to use Firebase instead of local server because of:
    * usage without running server
    * database was easier to implement, change, delete
    * easier to insert data in database
    * easier to use Firebase user id (also safer)
    * at first it seemed difficult to download Firebase data into the app and properly into usable structs, but once I knew how, it seemed more convenient than the flask server
* copied old files to computer and changed files on GitHub repository to 

* added global getData() functions to load all data from firebase into app
    * within app only change data online and then call getData() again

## day 9
* added functionality to drinks section
     * drinks behind (visible under segment control at lubrication overview)
* landscape design

