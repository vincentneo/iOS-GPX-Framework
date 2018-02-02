//
//  GPXTests.m
//  GPXTests
//
//  Created by 俊紀 渡辺 on 12/04/06.
//  Copyright (c) 2012年 _MyCompanyName_. All rights reserved.
//

#import "GPXTests.h"
#import "GPX.h"

@implementation GPXTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGPX
{
    NSString *path = [[NSBundle bundleForClass:[GPXParser class]] pathForResource:@"mystic_basin_trail" ofType:@"gpx"];

    GPXRoot *root = [GPXParser parseGPXAtPath:path];
    
    // gpx
    STAssertNotNil(root, nil);
    STAssertEqualObjects(root.creator, @"ExpertGPS 1.1b1 - http://www.topografix.com", nil);

    // gpx > metadata
    GPXMetadata *metadata = root.metadata;
    STAssertNotNil(metadata, nil);
    STAssertEqualObjects(metadata.name, @"Mystic River Basin Trails", nil);
    STAssertEqualObjects(metadata.desc, @"Both banks of the lower Mystic River have paved trails, allowing for a short and a long loop along the water.  The short loop is a two mile trail with no road crossings.  The long loop adds side-trips out to Draw Seven Park and the MBTA yard at Wellington Station, but crosses the six lanes of Route 28 twice.", nil);

    GPXAuthor *author = metadata.author;
    STAssertNotNil(author, nil);
    STAssertEqualObjects(author.name, @"Dan Foster", nil);
    GPXEmail *authorEmail = author.email;
    STAssertNotNil(authorEmail, nil);
    STAssertEqualObjects(authorEmail.emailID, @"trails", nil);
    STAssertEqualObjects(authorEmail.domain, @"topografix.com", nil);
    GPXLink *authorLink = author.link;
    STAssertNotNil(authorLink, nil);
    STAssertEqualObjects(authorLink.href, @"http://www.tufts.edu/mystic/amra/pamphlet.html", nil);
    STAssertEqualObjects(authorLink.text, @"Lower Mystic Basin Trails", nil);
    
    GPXCopyright *copyright = metadata.copyright;
    STAssertNotNil(copyright, nil);
    STAssertEqualObjects(copyright.author, @"Dan Foster", nil);
    STAssertEqualObjects(copyright.license, @"http://creativecommons.org/licenses/by/2.0/", nil);
    
    GPXLink *link = metadata.link;
    STAssertNotNil(link, nil);
    STAssertEqualObjects(link.href, @"http://www.topografix.com/gpx.asp", nil);
    STAssertEqualObjects(link.text, @"GPX site", nil);
    STAssertEqualObjects(link.mimetype, @"text/html", nil);
    
    // gpx > wpt
    STAssertEquals((NSInteger)root.waypoints.count, (NSInteger)23, nil);
    
    GPXWaypoint *waypoint;

    waypoint = [root.waypoints objectAtIndex:0];
    STAssertEquals((float)waypoint.latitude, 42.398167f, nil);
    STAssertEquals((float)waypoint.longitude, -71.083339f, nil);
    STAssertEqualObjects(waypoint.name, @"205A", nil);
    STAssertEqualObjects(waypoint.desc, @"Concrete platform looking out onto the Mystic.\nWhile you take in the view, try not to think about the fact that you're standing on top of MWRA Wet Water Discharge Outflow #205A", nil);

    waypoint = [root.waypoints objectAtIndex:2];
    STAssertEquals((float)waypoint.latitude, 42.398467f, nil);
    STAssertEquals((float)waypoint.longitude, -71.090467f, nil);
    STAssertEqualObjects(waypoint.name, @"BLESSING", nil);
    STAssertEqualObjects(waypoint.desc, @"The Blessing of the Bay Boathouse, now run by the Somerville Boys and Girls Club.\nA dock with small boats for the children of Somerville.  Check out the Mystic River mural at the intersection of Shore Drive and Rt 16!", nil);
    STAssertEquals((int)waypoint.links.count, (int)1, nil);
    GPXLink *waypointLink = [waypoint.links objectAtIndex:0];
    STAssertEqualObjects(waypointLink.href, @"http://www.everydaydesign.com/ourtown/bay.html", nil);
    STAssertEqualObjects(waypointLink.text, @"Boat-building on the Mystic River", nil);

    waypoint = [root.waypoints objectAtIndex:22];
    STAssertEquals((float)waypoint.latitude, 42.395889f, nil);
    STAssertEquals((float)waypoint.longitude, -71.077949f, nil);
    STAssertEqualObjects(waypoint.name, @"YACHT CLUB", nil);
    STAssertEqualObjects(waypoint.desc, @"Winter Hill Yacht Club", nil);

    // gpx > rte
    STAssertEquals((NSInteger)root.routes.count, (NSInteger)2, nil);

    GPXRoute *route;
    GPXRoutePoint *routepoint;
    
    route = [root.routes objectAtIndex:0];
    STAssertEqualObjects(route.name, @"LONG LOOP", nil);
    STAssertEqualObjects(route.desc, @"The long loop around the Mystic River, with stops at Draw Seven Park and the MBTA yard at Wellington Station (Orange Line).  Crosses Route 28 twice", nil);
    STAssertEquals((NSInteger)route.number, (NSInteger)1, nil);
    STAssertEquals((NSInteger)route.routepoints.count, (NSInteger)18, nil);

    routepoint = [route.routepoints objectAtIndex:0];
    STAssertEquals((float)routepoint.latitude, 42.405495f, nil);
    STAssertEquals((float)routepoint.longitude, -71.098364f, nil);
    STAssertEqualObjects(routepoint.name, @"LOOP", nil);
    STAssertEqualObjects(routepoint.desc, @"Starting point for the Mystic River loop trails.", nil);

    routepoint = [route.routepoints objectAtIndex:9];
    STAssertEquals((float)routepoint.latitude, 42.400554f, nil);
    STAssertEquals((float)routepoint.longitude, -71.079901f, nil);
    STAssertEqualObjects(routepoint.name, @"WELL YACHT", nil);
    STAssertEqualObjects(routepoint.desc, @"Mystic Wellington Yacht Club", nil);

    routepoint = [route.routepoints objectAtIndex:17];
    STAssertEquals((float)routepoint.latitude, 42.405495f, nil);
    STAssertEquals((float)routepoint.longitude, -71.098364f, nil);
    STAssertEqualObjects(routepoint.name, @"LOOP", nil);
    STAssertEqualObjects(routepoint.desc, @"Starting point for the Mystic River loop trails.", nil);
    
    route = [root.routes objectAtIndex:1];
    STAssertEqualObjects(route.name, @"SHORT LOOP", nil);
    STAssertEqualObjects(route.desc, @"Short Mystic River loop.\nThis loop circles the portion of the Mystic River enclosed by Routes 93, 16, and 28.  It's short, but you can do the entire loop without crossing any roads.", nil);
    STAssertEquals((NSInteger)route.number, (NSInteger)3, nil);
    STAssertEquals((NSInteger)route.routepoints.count, (NSInteger)8, nil);
    
    routepoint = [route.routepoints objectAtIndex:0];
    STAssertEquals((float)routepoint.latitude, 42.405495f, nil);
    STAssertEquals((float)routepoint.longitude, -71.098364f, nil);
    STAssertEqualObjects(routepoint.name, @"LOOP", nil);
    STAssertEqualObjects(routepoint.desc, @"Starting point for the Mystic River loop trails.", nil);

    routepoint = [route.routepoints objectAtIndex:3];
    STAssertEquals((float)routepoint.latitude, 42.399733f, nil);
    STAssertEquals((float)routepoint.longitude, -71.083567f, nil);
    STAssertEqualObjects(routepoint.name, @"RT 28", nil);
    STAssertEqualObjects(routepoint.desc, @"Wellington Bridge\nRoute 28 crosses the Mystic River on this 6 lane bridge.  Pedestrian walkways on both sides.  Access to the Assembly Square mall is at the south end of the bridge.", nil);

    routepoint = [route.routepoints objectAtIndex:7];
    STAssertEquals((float)routepoint.latitude, 42.405495f, nil);
    STAssertEquals((float)routepoint.longitude, -71.098364f, nil);
    STAssertEqualObjects(routepoint.name, @"LOOP", nil);
    STAssertEqualObjects(routepoint.desc, @"Starting point for the Mystic River loop trails.", nil);

    // gpx > trk
    STAssertEquals((NSInteger)root.tracks.count, (NSInteger)3, nil);
    
    GPXTrack *track;
    GPXTrackSegment *tracksegment;
    GPXTrackPoint *trackpoint;
    
    track = [root.tracks objectAtIndex:0];
    STAssertEqualObjects(track.name, @"LONG TRACK", nil);
    STAssertEqualObjects(track.desc, @"Tracklog from Long Loop", nil);
    STAssertEquals((NSInteger)track.number, (NSInteger)2, nil);
    STAssertEquals((NSInteger)track.tracksegments.count, (NSInteger)1, nil);
    tracksegment = [track.tracksegments objectAtIndex:0];
    STAssertEquals((NSInteger)tracksegment.trackpoints.count, (NSInteger)166, nil);
    trackpoint = [tracksegment.trackpoints objectAtIndex:0];
    STAssertEquals((float)trackpoint.latitude, 42.405488f, nil);
    STAssertEquals((float)trackpoint.longitude, -71.098173f, nil);
    trackpoint = [tracksegment.trackpoints objectAtIndex:82];
    STAssertEquals((float)trackpoint.latitude, 42.399266f, nil);
    STAssertEquals((float)trackpoint.longitude, -71.083581f, nil);
    trackpoint = [tracksegment.trackpoints objectAtIndex:165];
    STAssertEquals((float)trackpoint.latitude, 42.405703f, nil);
    STAssertEquals((float)trackpoint.longitude, -71.098065f, nil);

    track = [root.tracks objectAtIndex:1];
    STAssertEqualObjects(track.name, @"SHORT TRACK", nil);
    STAssertEqualObjects(track.desc, @"Bike path along the Mystic River in Medford.\nThe trail runs along Interstate 93 to Shore Road.  It then crosses the Mystic on the Route 38 bridge near the Assembly Square mall.  After the bridge, the trail cuts through the high meadow grass behind the State Police barracks, and enters Torbert McDonald Park.  Leaving the park, the trail passes the Meadow Glen mall before crossing back over the Mystic on the Rt 16 bridge.", nil);
    STAssertEquals((NSInteger)track.number, (NSInteger)4, nil);
    STAssertEquals((NSInteger)track.tracksegments.count, (NSInteger)1, nil);
    tracksegment = [track.tracksegments objectAtIndex:0];
    STAssertEquals((NSInteger)tracksegment.trackpoints.count, (NSInteger)95, nil);
    trackpoint = [tracksegment.trackpoints objectAtIndex:0];
    STAssertEquals((float)trackpoint.latitude, 42.405381f, nil);
    STAssertEquals((float)trackpoint.longitude, -71.098108f, nil);
    trackpoint = [tracksegment.trackpoints objectAtIndex:48];
    STAssertEquals((float)trackpoint.latitude, 42.403944f, nil);
    STAssertEquals((float)trackpoint.longitude, -71.085405f, nil);
    trackpoint = [tracksegment.trackpoints objectAtIndex:94];
    STAssertEquals((float)trackpoint.latitude, 42.405660f, nil);
    STAssertEquals((float)trackpoint.longitude, -71.098280f, nil);


    track = [root.tracks objectAtIndex:2];
    STAssertEqualObjects(track.name, @"TUFTS CONNECT", nil);
    STAssertEqualObjects(track.desc, @"Connecting route from Tufts Park to beginning of Mystic Basin loop trail.", nil);
    STAssertEquals((NSInteger)track.number, (NSInteger)5, nil);
    STAssertEquals((NSInteger)track.tracksegments.count, (NSInteger)1, nil);
    tracksegment = [track.tracksegments objectAtIndex:0];
    STAssertEquals((NSInteger)tracksegment.trackpoints.count, (NSInteger)24, nil);
    trackpoint = [tracksegment.trackpoints objectAtIndex:0];
    STAssertEquals((float)trackpoint.latitude, 42.402356f, nil);
    STAssertEquals((float)trackpoint.longitude, -71.107807f, nil);
    trackpoint = [tracksegment.trackpoints objectAtIndex:11];
    STAssertEquals((float)trackpoint.latitude, 42.405317f, nil);
    STAssertEquals((float)trackpoint.longitude, -71.103923f, nil);
    trackpoint = [tracksegment.trackpoints objectAtIndex:23];
    STAssertEquals((float)trackpoint.latitude, 42.405424f, nil);
    STAssertEquals((float)trackpoint.longitude, -71.098173f, nil);
}

@end
