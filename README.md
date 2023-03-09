# Blog App

# An Assessment Project.
A simple app that displays blog posts by authors using the [Json Placeholder API.](https://jsonplaceholder.typicode.com/)

## ✨✨ Features
- Viewing posts.
- Bookmarking posts.
- Sharing posts.
- Search (By Title)

## 🛠 Essential Plugins / Packages Used
- Dartz (For Funtional Programming - Mostly used for error handling and introducing Tuples in my case)
- Http
- Hive (For Local Storage)
- Bloc (For State Management) 
- Internet Connection Checker
- Equatable (For checking equality of Objects)
- Get-It (For Dependency Injection)

## Getting Started
You have to have Flutter installed in your machine. Clone this repository and run `flutter pub get`.
I am currently running `Flutter version 3.7.6` with `Dart version 2.19.3`.

## 📖 Brief
This project as previously stated is a simple blog app for users to read blog posts. They can share, search and bookmark posts. 

It also includes a Caching mechanism that stores posts locally when, this is so that the user has something to read at when there is no internet connection (I understand that this might make errors hard to see, so to really see how errors are handled, please make sure to clear cache and run the app without internet connection to see how errors are displayed).

* Edge case:
The user details were not included in the `/posts` path on our API so I had to make another call to get the list of users. I returned both Posts and Users for every request made using a Tuple. This allows for cleaner and less verbose code. I applied this to every other parts where the Users (Authors) were needed.


The app can be used offline also. All functionalities still exist as long as all data needed were stored locally.
