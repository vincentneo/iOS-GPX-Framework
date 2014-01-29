//
//  GPXLibTests.m
//  GPXLibTests
//
//  Created by Felix Lamouroux on 29.01.14.
//
//

#import <XCTest/XCTest.h>
#import "GPX.h"

@interface GPXLibTests : XCTestCase

@end

@implementation GPXLibTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSString *path = [[NSBundle bundleForClass:[GPXParser class]] pathForResource:@"mystic_basin_trail" ofType:@"gpx"];
    
    GPXRoot *root = [GPXParser parseGPXAtPath:path];
    
    // gpx
    XCTAssertNotNil(root);
    XCTAssertEqualObjects(root.creator, @"ExpertGPS 1.1b1 - http://www.topografix.com");
    
    // gpx > metadata
    GPXMetadata *metadata = root.metadata;
    XCTAssertNotNil(metadata);
    XCTAssertTrue([metadata.name isEqualToString:@"Mystic River Basin Trails"]);
    XCTAssertTrue([metadata.desc isEqualToString:@"Both banks of the lower Mystic River have paved trails, allowing for a short and a long loop along the water.  The short loop is a two mile trail with no road crossings.  The long loop adds side-trips out to Draw Seven Park and the MBTA yard at Wellington Station, but crosses the six lanes of Route 28 twice."]);
    
    GPXAuthor *author = metadata.author;
    XCTAssertNotNil(author);
    XCTAssertEqualObjects(author.name, @"Dan Foster");
    GPXEmail *authorEmail = author.email;
    XCTAssertNotNil(authorEmail);
    XCTAssertEqualObjects(authorEmail.emailID, @"trails");
    XCTAssertEqualObjects(authorEmail.domain, @"topografix.com");
    GPXLink *authorLink = author.link;
    XCTAssertNotNil(authorLink);
    XCTAssertEqualObjects(authorLink.href, @"http://www.tufts.edu/mystic/amra/pamphlet.html");
    XCTAssertEqualObjects(authorLink.text, @"Lower Mystic Basin Trails");
    
    GPXCopyright *copyright = metadata.copyright;
    XCTAssertNotNil(copyright);
    XCTAssertEqualObjects(copyright.author, @"Dan Foster");
    XCTAssertEqualObjects(copyright.license, @"http://creativecommons.org/licenses/by/2.0/");
    
    GPXLink *link = metadata.link;
    XCTAssertNotNil(link);
    XCTAssertEqualObjects(link.href, @"http://www.topografix.com/gpx.asp");
    XCTAssertEqualObjects(link.text, @"GPX site");
    XCTAssertEqualObjects(link.mimetype, @"text/html");
    
    // gpx > wpt
    XCTAssertEqual(root.waypoints.count, 23U);
    
    GPXWaypoint *waypoint;
    
    waypoint = [root.waypoints objectAtIndex:0];
    XCTAssertEqual(waypoint.latitude, 42.398167);
    XCTAssertEqual(waypoint.longitude, -71.083339);
    XCTAssertEqualObjects(waypoint.name, @"205A");
    XCTAssertEqualObjects(waypoint.desc, @"Concrete platform looking out onto the Mystic.\nWhile you take in the view, try not to think about the fact that you're standing on top of MWRA Wet Water Discharge Outflow #205A");
    
    waypoint = [root.waypoints objectAtIndex:2];
    XCTAssertEqual(waypoint.latitude, 42.398467);
    XCTAssertEqual(waypoint.longitude, -71.090467);
    XCTAssertEqualObjects(waypoint.name, @"BLESSING");
    XCTAssertEqualObjects(waypoint.desc, @"The Blessing of the Bay Boathouse, now run by the Somerville Boys and Girls Club.\nA dock with small boats for the children of Somerville.  Check out the Mystic River mural at the intersection of Shore Drive and Rt 16!");
    XCTAssertEqual(waypoint.links.count, 1U);
    GPXLink *waypointLink = [waypoint.links objectAtIndex:0];
    XCTAssertEqualObjects(waypointLink.href, @"http://www.everydaydesign.com/ourtown/bay.html");
    XCTAssertEqualObjects(waypointLink.text, @"Boat-building on the Mystic River");
    
    waypoint = [root.waypoints objectAtIndex:22];
    XCTAssertEqual(waypoint.latitude, 42.395889);
    XCTAssertEqual(waypoint.longitude, -71.077949);
    XCTAssertEqualObjects(waypoint.name, @"YACHT CLUB");
    XCTAssertEqualObjects(waypoint.desc, @"Winter Hill Yacht Club");
    
    // gpx > rte
    XCTAssertEqual(root.routes.count, 2U);
    
    GPXRoute *route;
    GPXRoutePoint *routepoint;
    
    route = [root.routes objectAtIndex:0];
    XCTAssertEqualObjects(route.name, @"LONG LOOP");
    XCTAssertTrue([route.desc isEqualToString:@"The long loop around the Mystic River, with stops at Draw Seven Park and the MBTA yard at Wellington Station (Orange Line).  Crosses Route 28 twice"], @"Desc was \"%@\"", route.desc);
    XCTAssertEqual(route.number, 1);
    XCTAssertEqual(route.routepoints.count, 18U);
    
    routepoint = [route.routepoints objectAtIndex:0];
    XCTAssertEqual(routepoint.latitude, 42.405495);
    XCTAssertEqual(routepoint.longitude, -71.098364);
    XCTAssertEqualObjects(routepoint.name, @"LOOP");
    XCTAssertEqualObjects(routepoint.desc, @"Starting point for the Mystic River loop trails.");
    
    routepoint = [route.routepoints objectAtIndex:9];
    XCTAssertEqual(routepoint.latitude, 42.400554);
    XCTAssertEqual(routepoint.longitude, -71.079901);
    XCTAssertEqualObjects(routepoint.name, @"WELL YACHT");
    XCTAssertEqualObjects(routepoint.desc, @"Mystic Wellington Yacht Club");
    
    routepoint = [route.routepoints objectAtIndex:17];
    XCTAssertEqual(routepoint.latitude, 42.405495);
    XCTAssertEqual(routepoint.longitude, -71.098364);
    XCTAssertEqualObjects(routepoint.name, @"LOOP");
    XCTAssertEqualObjects(routepoint.desc, @"Starting point for the Mystic River loop trails.");
    
    route = [root.routes objectAtIndex:1];
    XCTAssertEqualObjects(route.name, @"SHORT LOOP");
    XCTAssertEqualObjects(route.desc, @"Short Mystic River loop.\nThis loop circles the portion of the Mystic River enclosed by Routes 93, 16, and 28.  It's short, but you can do the entire loop without crossing any roads.", @"Desc was \"%@\"", route.desc);
    XCTAssertEqual(route.number, 3);
    XCTAssertEqual(route.routepoints.count, 8U);
    
    routepoint = [route.routepoints objectAtIndex:0];
    XCTAssertEqual(routepoint.latitude, 42.405495);
    XCTAssertEqual(routepoint.longitude, -71.098364);
    XCTAssertEqualObjects(routepoint.name, @"LOOP");
    XCTAssertEqualObjects(routepoint.desc, @"Starting point for the Mystic River loop trails.");
    
    routepoint = [route.routepoints objectAtIndex:3];
    XCTAssertEqual(routepoint.latitude, 42.399733);
    XCTAssertEqual(routepoint.longitude, -71.083567);
    XCTAssertEqualObjects(routepoint.name, @"RT 28");
    XCTAssertEqualObjects(routepoint.desc, @"Wellington Bridge\nRoute 28 crosses the Mystic River on this 6 lane bridge.  Pedestrian walkways on both sides.  Access to the Assembly Square mall is at the south end of the bridge.");
    
    routepoint = [route.routepoints objectAtIndex:7];
    XCTAssertEqual(routepoint.latitude, 42.405495);
    XCTAssertEqual(routepoint.longitude, -71.098364);
    XCTAssertEqualObjects(routepoint.name, @"LOOP");
    XCTAssertEqualObjects(routepoint.desc, @"Starting point for the Mystic River loop trails.");
    
    // gpx > trk
    XCTAssertEqual(root.tracks.count, 3U);
    
    GPXTrack *track;
    GPXTrackSegment *tracksegment;
    GPXTrackPoint *trackpoint;
    
    track = [root.tracks objectAtIndex:0];
    XCTAssertEqualObjects(track.name, @"LONG TRACK");
    XCTAssertEqualObjects(track.desc, @"Tracklog from Long Loop");
    XCTAssertEqual(track.number, 2);
    XCTAssertEqual(track.tracksegments.count, 1u);
    tracksegment = [track.tracksegments objectAtIndex:0];
    XCTAssertEqual(tracksegment.trackpoints.count, 166U);
    trackpoint = [tracksegment.trackpoints objectAtIndex:0];
    XCTAssertEqual(trackpoint.latitude, 42.405488);
    XCTAssertEqual(trackpoint.longitude, -71.098173);
    trackpoint = [tracksegment.trackpoints objectAtIndex:82];
    XCTAssertEqual(trackpoint.latitude, 42.399266);
    XCTAssertEqual(trackpoint.longitude, -71.083581);
    trackpoint = [tracksegment.trackpoints objectAtIndex:165];
    XCTAssertEqual(trackpoint.latitude, 42.405703);
    XCTAssertEqual(trackpoint.longitude, -71.098065);
    
    track = [root.tracks objectAtIndex:1];
    XCTAssertEqualObjects(track.name, @"SHORT TRACK");
    XCTAssertTrue([track.desc isEqualToString:@"Bike path along the Mystic River in Medford.\nThe trail runs along Interstate 93 to Shore Road.  It then crosses the Mystic on the Route 38 bridge near the Assembly Square mall.  After the bridge, the trail cuts through the high meadow grass behind the State Police barracks, and enters Torbert McDonald Park.  Leaving the park, the trail passes the Meadow Glen mall before crossing back over the Mystic on the Rt 16 bridge."], @"Desc was \"%@\"", track.desc);
    XCTAssertEqual(track.number, 4);
    XCTAssertEqual(track.tracksegments.count, 1u);
    tracksegment = [track.tracksegments objectAtIndex:0];
    XCTAssertEqual(tracksegment.trackpoints.count, 95U);
    trackpoint = [tracksegment.trackpoints objectAtIndex:0];
    XCTAssertEqual(trackpoint.latitude, 42.405381);
    XCTAssertEqual(trackpoint.longitude, -71.098108);
    trackpoint = [tracksegment.trackpoints objectAtIndex:48];
    XCTAssertEqual(trackpoint.latitude, 42.403944);
    XCTAssertEqual(trackpoint.longitude, -71.085405);
    trackpoint = [tracksegment.trackpoints objectAtIndex:94];
    XCTAssertEqual(trackpoint.latitude, 42.405660);
    XCTAssertEqual(trackpoint.longitude, -71.098280);
    
    
    track = [root.tracks objectAtIndex:2];
    XCTAssertEqualObjects(track.name, @"TUFTS CONNECT");
    XCTAssertEqualObjects(track.desc, @"Connecting route from Tufts Park to beginning of Mystic Basin loop trail.");
    XCTAssertEqual(track.number, 5);
    XCTAssertEqual(track.tracksegments.count, 1u);
    tracksegment = [track.tracksegments objectAtIndex:0];
    XCTAssertEqual(tracksegment.trackpoints.count, 24U);
    trackpoint = [tracksegment.trackpoints objectAtIndex:0];
    XCTAssertEqual(trackpoint.latitude, 42.402356);
    XCTAssertEqual(trackpoint.longitude, -71.107807);
    trackpoint = [tracksegment.trackpoints objectAtIndex:11];
    XCTAssertEqual(trackpoint.latitude, 42.405317);
    XCTAssertEqual(trackpoint.longitude, -71.103923);
    trackpoint = [tracksegment.trackpoints objectAtIndex:23];
    XCTAssertEqual(trackpoint.latitude, 42.405424);
    XCTAssertEqual(trackpoint.longitude, -71.098173);}

@end
