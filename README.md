# Giphy Search

A small app that presents a search bar for entering a search term to query the giphy search api and display those gif results in a table view. I use the FLAnimatedImage package via Swift Package Manager to handle displaying the gif data as there is a lot of overhead and no current apple defined way to display gifs.

The network layer of the app uses the Result type to simplify our success and failure states. We also use async await to handle asynchronous network calls without completion handlers.

### Architecture 

This app is structured with MVVM architecture. using a view model to separate the view controller code from business logic changes to the model. The app also uses protocols to decouple our dependancy injection and make our viewmodel easier to test. 

### Running the app
The app was built with Xcode 13.4 and targets iOS 15 when opening the app for the first time you may run into the following error: 

`Package.resolved file is corrupt or malformed`

You can follow the steps at the following [stackoverflow answer](https://stackoverflow.com/a/69389411) to resolve that error. From there you should be able to build the app to an iPhone Simulator

### What to improve and add
1. I would add and data cacher so that FLAnimatedImage's can be stored to reduce network calls
2. I would look at adapting Diffable Data Sources as that would allow the implementation of pre-fetching to aid smooth scrolling performance
3. Auto-suggest drop-down on search bar
4. Add pagination requests
5. Add the ability to favorite a gif and have a favorites view navigated to via tab