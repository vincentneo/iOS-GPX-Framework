[![License](http://img.shields.io/:license-mit-blue.svg)](http://opensource.org/licenses/mit-license.php)
[![Build](https://travis-ci.org/Pierre-Loup/iOS-GPX-Framework.svg)](https://travis-ci.org/Pierre-Loup/iOS-GPX-Framework)

iOS GPX Framework
============================

This is a iOS framework for parsing/generating GPX files.
This Framework parses the GPX from a URL or Strings and create Objective-C Instances of GPX structure. 

Fork infos
---------------------------------
This pod is the "iOS-GPX-Framework" pod's source repo. It has been created to migrate from a static framework based dependency mamagement to Cocoapods.


Installation with CocoaPods
---------------------------------

#### Podfile

```ruby
platform :ios, '5.1'
pod 'iOS-GPX-Framework', "~> 0.0"
```

How to use the framework
---------------------------------

Import the umbrella header

	#import "KML.h"


To parsing the GPX file, simply call the parse method :

	GPXRoot *root = [GPXParser parseGPXWithString:gpx];


You can generate the GPX :

    GPXRoot *root = [GPXRoot rootWithCreator:@"Sample Application"];
    
    GPXWaypoint *waypoint = [root newWaypointWithLatitude:35.658609f longitude:139.745447f];
    waypoint.name = @"Tokyo Tower";
    waypoint.comment = @"The old TV tower in Tokyo.";
    
    GPXTrack *track = [root newTrack];
    track.name = @"My New Track";
    
    [track newTrackpointWithLatitude:35.658609f longitude:139.745447f];
    [track newTrackpointWithLatitude:35.758609f longitude:139.745447f];
    [track newTrackpointWithLatitude:35.828609f longitude:139.745447f];


Acknowledgment
---------------------------------

[TBXML](http://tbxml.co.uk/TBXML/TBXML_Free.html) Copyright (c) 2009 Tom Bradley