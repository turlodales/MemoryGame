SoundCloud Memory Game
========================
The memory game with a grid of 4x4 cells written in Swift.

# Requirements
1. iOS 9.0+
2. XCode 10.0
3. Swift 4.0+
4. Cocoapods (Dependency Manager)

# Development Setup & Build App
1. Open a terminal and go to project directory.
2. Install Cocoapods with command `sudo gem install cocoapods`
3. Install dependencies via `pod install`
4. Please open `.xcworkspace` file,  not `.xcodeproj`.
5. Hit the run button!

# Project 

### App UI Flow
Application consists of three different pages. 
1. Initial Page: This is the beginning page of the application. You can either start the game button or learn how to play button.
2. Game Page: This is where game is played by user.
3. Game Complete Page:  When the game finishes, app is navigated to that page.

### App Logic Flow

When user taps to "Play Game" button;

1. New `GameSetup` instance will be instantiated. That class will send a request to `SoundCloud API` and retrieve the tracks. Then that class will prepare cards and instantiate Game instance. State changes are listened by the `InitialViewController`, If anything fails, error message will be prompted. If everything is OK, then game view controller is presented.

2. GameViewController starts with a game instance. That view controller will append card views into a `StackView` and prepare the layout. Also, `Game` class will handle the Memory Game logic and it has delegate instance to invoke `show`, `hide` cards and `finish` the game.

3. When game is finished, `GameResultViewController` is presented.


### Project Architecture

Model-View-Controller(MVC) architecture is used.

### Environment Variables
There is an `Environment.swift` file under `Util` folder. This file is containing app specific constants like Api URL, Client Id and Client Secret etc. It's designed with a such structure to deliver the app for multiple environments for debug or release. If you build the app with Debug, app logs will be shown.

# Testing App
There are two different folders within the project. These are `SoundCloudMemoryUnitTests` and `SoundCloudMemoryUITests`

### Unit Tests
Unit tests resides in `SoundCloudMemoryUnitTests` folder structure. Each folder is corresponding to a class in the application level. 

### UI Tests
UI tests reside just under `SoundCloudMemoryUITests` folder.

# Cocoapods
Cocoapods is used as dependency manager to manage 3rd party libraries and resources. See also [Cocoapods](http://cocoapods.org)
