# Design Document

### UI sketches

![sketch](/docs/sketch.png)

### UML Diagram

![diagram](/docs/diagram.png)

### Data Source
* Google Firebase Authentication
* Google Firebase realtime cyncing for JSON data

### Data Structure

* Users table (authentication) -> linked to realtime data via user id
* realtime data table

|  User          | House              |
|----------------|--------------------|
| id             | id                 |
| name           | name               |
| email          | residents: [user id's] |
| house          | cleaning schedule  |
| (isHouseOwner) | drinks             |
