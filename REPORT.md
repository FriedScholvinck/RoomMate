# Final Report

links to files!!!

## Short description
RoomMate is an iPhone application for students. It contains a simple, weekly cleaning schedule and the functionality to keep a beer drinking system up to date.

## Technical design

### Structure
The initial view controller (AppContainerViewController.swift) is one which the user never sees and passes the user through to the login/register page (LogInViewController.swift) or, when the user is already logged in, to the home page (HomeViewController.swift). The login page is helped by standard Google Firebase Authentication, which can not be seen in the main.storyboard. From there, the app is build up of a tab bar controller with 4 tabs: 'Home', 'Clean', 'Drinks' and 'Profile'. Each tab is embedded in a navigation controller for easy navigation between view controllers.

### Components

##### General files
* AppContainerViewController
* AppManager
* LoginViewController
* Extensions
* DataController
* Structures

##### Home
* Dinner

##### Clean
* Create New Schedule

##### Drinks
* Change Total Drinks
* Overview
    * Drinks to buy
    * Total drinks per resident

##### Profile
* Your House
* Pick House
* Create New House
* About this app


### Data
DataController.swift holds functions to get all data from the Google Firebase Realtime Database linked to the app. The functions ensure that data is saved locally into a global struct inside Structures.swift.  


### Extensions
Extensions can be found in Extensions.swift. An important function in there is called getAllData() and calls the DataController to fetch all users and houses. Other extensions are there to reduce the amount of code.


## Challenges
... important changes in process




