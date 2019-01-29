# Final Report

## Short description
RoomMate is an iPhone application for students. It contains a simple, weekly shifting cleaning schedule and the functionality to keep a beer drinking system up to date.

## Technical design

### App Flow
![flow](/docs/flow.png)

### Structure
The initial view controller [AppContainerViewController](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/AppContainerViewController.swift) is one which the user never sees and passes the user through to the login/register page [LogInViewController](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/LogInViewController.swift) or, when the user is already logged in, to the home page [HomeViewController](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Home/HomeViewController.swift). The login page is helped by standard Google Firebase Authentication, which can not be seen in the main.storyboard. From there, the app is build up of a tab bar controller with 4 tabs: 'Home', 'Clean', 'Drinks' and 'Profile'. Each tab is embedded in a navigation controller for easy navigation between view controllers.

### Components

##### General files
* [AppContainerViewController](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/AppContainerViewController.swift)
* [AppManager](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/AppManager.swift)
* [LoginViewController](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/LogInViewController.swift)
* [Extensions](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Extenstions.swift)
* [DataController](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/DataController.swift)
* [Structures](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Structures.swift)

##### [Home](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Home/HomeViewController.swift)
* [Dinner](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Home/DinnerTableViewController.swift)

##### [Clean](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Clean/CleanViewController.swift)
* [Create New Schedule](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Clean/NewScheduleViewController.swift)

##### [Drinks](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Drinks/DrinkViewController.swift)
* [Change Total Drinks](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Drinks/AddDrinksViewController.swift)
* [Overview](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Drinks/OverviewDrinksViewController.swift)
    * Drinks to buy
    * Total drinks per resident

##### [Profile](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Profile/ProfileViewController.swift)
* [Your House](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Profile/YourHouseViewController.swift)
* [Pick House](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Profile/PickHouseViewController.swift)
* [Create New House](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Profile/NewHouseViewController.swift)
* [About this app](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Profile/AboutViewController.swift)


### Data
[DataController](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/DataController.swift) holds functions to get all data from the Google Firebase Realtime Database linked to the app. The functions ensure that data is saved locally into a global struct inside Structures.swift.  


### Extensions
Extensions can be found in [Extensions](https://github.com/FriedScholvinck/RoomMate/blob/master/code/RoomMate/Extenstions.swift). An important function in there is called getAllData() and calls the DataController to fetch all users and houses. Other extensions are there to reduce the amount of code.


## Challenges
* The first challenge was to create an online database. I didn't know where to start and heard about Google Firebase, so decided to take a look. Getting users to sign in was fairly simple, but I was told the Realtime Database could be very difficult to work with. However, when I succeeded in getting the JSON data into my app, it seemed easier to work with than the FLASK local server. In the end, I'm glad I choose to use Firebase, because I don't have to run the database on my own computer.
* The structure of the database was straightforward. The difficult thing was to get lists of users into houses. I decided to structure it like this:

![datastructure](/docs/datastructure.png)


### Creating a clever drinking system
I first implemented the drinking system, which seemed easier than the cleaning schedule. It had to be simple, but also fully changeable. Users should be able to enter their bought drinks, but also to just change the current amount of drinks in the house.

The drinking system could be used in multiple ways now:
* Buy beers from a joint account and just settle afterwards, depending on how much everyone has been drinking. The drinking data could then be set to zero.
* Every room mate buys beers for the house whenever he/she is in 'depth', depending on the variable 'Drinks To Buy'.

### Creating a cleaning schedule
At first, I haven't really had a plan for the cleaning schedule. I wanted it to be the exact same as a simple grid on paper, but then online. I based it on the system which many big student houses use: a weekly shifting schedule with big tasks as cleaning the bathroom, kitchen, living room or laundry room. A resident would pass in some tasks, and the app would create the schedule.
* How to show the schedule?
* What to do with less tasks than residents?
* What to do when the schedule is over
* How to calculate which task is due this week for the current user?

Answers to these questions came as I was building the app. I soon decided to not save the actual schedule online, but just the tasks, and let the app figure out which resident had to do which task which week. The most convenient way, I learned from implementing the drinking system first, was to show a table view with right detail and change the detail by segment control. The segment control would be the weeks in the schedule, the right detail would be the tasks to be done.
* If the user passes in less tasks than residents, the app has to account for these empty spots and also pass them into the schedule. If the user passes in more tasks, some tasks would not be done every week.
* The schedule is as long as the amount of residents in the house, because after those weeks, the schedule could start over and everyone has done every task once. A problem would come up when the schedule reaches the end of the year. I fixed that by starting the schedule again when a new year begins, regardless of whether the schedule has come to an end or not.
* Calculating which task to put on the home screen for the current user was quite difficult. First, I thought I could set a variable currentTask in the database for each user, but updating that turned out to be unwieldy in comparison to calculating the current task whenever the user would enter the 'Home' screen. I decided to let the getAllData() extension handle the division of the tasks whenever the data is downloaded from the database, so that the schedule could be put in the global struct, available to all view controllers.

## Changes with respect to proposal
As I go back to my proposal, I don't see very big changes I've made. The tab bar structure remained the same and there might have been some small changes in the implementation of the cleaning and drinking department. These were not very detailed in the first place. I added a the ability to see who eats at home tonight, didn't implement a points system for example. These were decisions I made after showing the app to friends and really thinking about the necessity of a points system. The goal was to create a simple replacement for easy-to-lose paper schedules and dash systems. Adding a point system would make it complicated. Users themselves can check whether a tasks has been done.

#### Extra feature: chatting
Something which could upgrade the app without making it more complicated for the user to understand is a chat function. Unfortunately, within the scope of this project, there was no time left to implement a chat function. I'd like to add it in the future though.



