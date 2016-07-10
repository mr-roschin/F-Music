#F-Music
--------
__F-Music__ is an iOS app created specially for F-Secure to demonstrate skills in coding, organizing and documenting.

##Check list:

- [x] "Create an iOS 9 app that can list 100 songs" - __DONE__.  _(Created an app that already stores 10 examples of songs and can store more. By adding CRUD features, a user is allowed to add own songs.)_
- [x] "Every row in the song list should show a picture, a song title and a band name" - __DONE__.
- [x] "When clicking on an item on the list, your app should show that song's details" - __DONE__
  - [x] "Picture" - __DONE__ _(additionally the album picture can be changed)_
  - [x] "Title" - __DONE__ _(additionally the song title can be changed)_
  - [x] "Band name" - __DONE__ _(additionally the band name can be changed)_
  - [x] "A randomly generated description text (200 characters long)" - __DONE__ _(used LoremSwiftum.framework for more realistic look of the text)_
- [x] "App should be nice to look at" - I hope it is nice to look at so __DONE__
- [x] "Support both landscape and portrait orientation" - __DONE__

###Bonus items:
- [x] Unit test - __DONE__ _(To create a data model to store the data that the app must display, was created a Track class with Title of a song, Name of an artist, Rating, Cover of the album and Description. Unit test was added to test this class.)_
- [x] Add more features - __DONE__
  * Add a new song
  * Edit a song _(edit a title, artist name, change picture of a cover, change rating)_
  * Delete a song
  * Reordering the rows in a table view.
  * Add rating to a song


Frameworks used:
----------------

   * __LoremSwiftum.framework__ was used for more realistic description text. (https://github.com/lukaskubanek/LoremSwiftum)
   * Chose __UIKit framework__ over a default __Foundation framework__, because used a class from UIKit. At the same time UIKit also gives access to Foundation framework.



Approaches used
---------------

In the project, Track.swift is responsible for storing and loading the properties, using NSCoding protocol. NSCoding was chosen due to its lightweight solution to store objects and other structures. The objects can be archived and retrieved any time later.
