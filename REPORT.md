# Final Report

links to files!!!

## Short description
RoomMate is an iPhone application for students. It contains a simple, weekly cleaning schedule and the functionality to keep a beer drinking system up to date.

## Technical design

### App Flow
![flow](/docs/flow.png)

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
* The first challenge was to create an online database. I didn't know where to start and heard about Google Firebase, so decided to take a look. Getting users to sign in was fairly simple, but I was told the Realtime Database could be very difficult to work with. However, when I succeeded in getting the JSON data into my app, it seemed easier to work with than the FLASK local server. In the end, I'm glad I choose to use Firebase, because I don't have to run the database on my own computer.
* The structure of the database was straightforward. The difficult thing was to get lists of users into houses. I decided to structure it like this:
![datastructure](/docs/datastructure.png)



