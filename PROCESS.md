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
* added 'about' view controller

## day 10
* set up house schedule in table view with segment control to change days/weeks
    * just like in the drinking section with 'drinks total' and 'drinks behind'
    * schedule changes automatically when new user comes in or day/week is changed
* prototype is finished
    * design layout
* next step: creating home screen
    * having some trouble with completion
        * decided to not show loading message (loading was short)

## day 11
* maken schedule work and moved it to first view controller in 'Clean' tab
* added completion functionality to getData()
* added new function 'Dinner Tonight'
    * switch button whether or not you'll eat at home tonight
* added icons, pictures
* had some problems with roommates drinking at the same time
    * fix: get all data again when drink button is tapped
* dinner function (notification every day for who eats at home only possible if you pay Apple)
    * set to zero from Firebase every day might be possible?
* struggle with scroll view (about section in Profile)
* cleaning schedule for 5 weeks now -> how to expend?

