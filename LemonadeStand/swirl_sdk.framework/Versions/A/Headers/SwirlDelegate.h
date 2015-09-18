// =====================================================================================================================
//  SwirlDelegate.h
//	Copyright (c) 2013-2015, Swirl Networks, Inc. All rights reserved.
// =====================================================================================================================

// Swirl SDK Delegate
// For additional details, please consult the documentation accompanying the SDK

// =====================================================================================================================
// System Headers (required system frameworks)
// =====================================================================================================================

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <Security/Security.h>

#ifndef __IPHONE_8_0
#error "Swirl SDK requires iOS SDK 8.0+ in order to support iOS 8.0+ devices."
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
#error "Swirl SDK requires iOS SDK 8.0+ in order to support iOS 8.0+ devices."
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
#error "Swirl SDK requires iOS deployment target of 7.0+"
#endif

// =====================================================================================================================
// SWRegion
// =====================================================================================================================

// SWRegions encapsulate metadata about geo-fences around Swirl-enabled locations
@interface SWRegion : NSObject
@property (nonatomic, readonly) NSString *			identifier;			// Region identifier
@property (nonatomic, readonly) NSString *			name;				// Name (for debugging mostly)
@property (nonatomic, readonly) CLCircularRegion *	region;				// Longitude, latitude, radius
@property (nonatomic, readonly) BOOL				hasBeacons;			// True if there are beacons
@property (nonatomic, readonly) BOOL				hasContent;			// True if there may be geo content
@property (nonatomic, readonly) NSArray *			uuids;				// UUID list of iBeacons
@property (nonatomic, readonly)	BOOL				entered;			// Is user inside region
@end

// =====================================================================================================================
// SWPlacement
// =====================================================================================================================

// SWPlacements encapsulate metadata about areas within a location containing beacons for content and/or reporting
@interface SWPlacement : NSObject
@property (nonatomic, readonly) NSString *			identifier;			// Placement identifier
@property (nonatomic, readonly) NSString *			name;				// Placement name
@property (nonatomic, readonly) NSString *			location;			// Location identifier
@property (nonatomic, readonly) NSString *			locationName;		// Location name
@property (nonatomic, readonly) NSString *          locationText;       // Location text for display
@property (nonatomic, readonly) NSString *			organization;		// Organization identifier
@property (nonatomic, readonly) NSString *			organizationName;	// Organization name
@property (nonatomic, readonly) BOOL				overlapping;		// Is placement overlapping
@property (nonatomic, readonly) BOOL				isprivate;			// access to placement level data is restricted
@end

// =====================================================================================================================
// SWBeaconStatus
// =====================================================================================================================

typedef enum {
	SWBeaconStatusUnknown = 0,											// Beacon initial state
	SWBeaconStatusResolving,											// Beacon is in progress of being resolved
	SWBeaconStatusOutside,												// Resolved, outside of current (or default) threshold
	SWBeaconStatusInside,												// Resolved, inside of current threshold
	SWBeaconStatusTimedOut,												// Have not heard from beacon within timeout
	SWBeaconStatusExpired,												// Exceeded cache lifetime
	SWBeaconStatusInvalid												// Beacon failed to resolve
} SWBeaconStatus;

// =====================================================================================================================
// SWBeacon
// =====================================================================================================================

// SWBeacons encapsulate the metadata about a specifiic hardware beacon encountered by the Swirl SDK
@interface SWBeacon : NSObject
@property (nonatomic, readonly) NSString *			identifier;			// Resolved id
@property (nonatomic, readonly) SWBeaconStatus		status;				// One of SWBeaconStatus
@property (nonatomic, readonly) int					pathloss;			// Last ping pathloss, invalid (255) after 5.0 seconds
@property (nonatomic, readonly) double				threshold;			// Enter/Exit trigger threshold (pathloss)
@property (nonatomic, readonly) int					power;				// Transmit power
@property (nonatomic, readonly) NSTimeInterval		created;			// Time of beacon creation (detection)
@property (nonatomic, readonly) NSTimeInterval		updated;			// Time of last received broadcast
@property (nonatomic, readonly)	NSTimeInterval		entered;			// Time of last enter
@property (nonatomic, readonly)	NSTimeInterval		exited;				// Time of last exit
@property (nonatomic, readonly) BOOL				overlapping;		// Is beacon overlapping
@property (nonatomic, readonly) BOOL				tap;				// Is tap beacon
@property (nonatomic, readonly) SWPlacement *		placement;			// Beacon placement
@property (nonatomic, readonly)	NSString *          serial;				// Serial # or n/a
@property (nonatomic, readonly)	BOOL				isprivate;			// access to beacon level data is restricted
@end

// =====================================================================================================================
// SWDelegate (callbacks)
// =====================================================================================================================

// Optional Swirl SDK delegate which can be provided to the Swirl SDK at startup for advanced eventing and feedback. See documentation for details.
// ** Swirl Retailer apps: All callbacks are supported **
// ** Swirl Publisher apps: Callbacks are restricted **
// All callbacks will occur on the main thread.
@protocol SWDelegate <NSObject>
@optional

// Swirl SDK Lifecycle and Authentication
- (void) didStart;
- (void) didLogin;
- (void) didFailLogin;
- (void) didChangeOptions;

// App Lifecycle
- (void) didBecomeActive;
- (void) didEnterForeground;
- (void) didEnterBackground;
- (void) didChangeNetworkReachability:(BOOL)up;

// Location and Region Events
- (void) didChangeLocation:(CLLocation *)location;
- (void) didEnterRegions:(NSArray *)entered inside:(NSArray *)inside;
- (void) didExitRegions:(NSArray *)exited inside:(NSArray *)inside;

// Beacon Events
- (void) didEnterBeacon:(SWBeacon *)beacon;
- (void) didExitBeacon:(SWBeacon *)beacon;
- (void) didPingBeacon:(SWBeacon *)beacon;

// Placement Events
- (void) didEnterPlacement:(SWPlacement *)placement time:(NSTimeInterval)time;
- (void) didExitPlacement:(SWPlacement *)placement time:(NSTimeInterval)time;
- (void) didPingPlacement:(SWPlacement *)placement time:(NSTimeInterval)time;

// Location Events
- (void) didEnterLocation:(SWPlacement *)placement time:(NSTimeInterval)time;
- (void) didExitLocation:(SWPlacement *)placement time:(NSTimeInterval)time;

// Content Event
- (BOOL) shouldShowNotification:(UILocalNotification *)note;
- (void) didReceiveContent:(NSArray *)content;

// Minimized View Events
- (BOOL) shouldShowMinimizedViewForLocation:(SWPlacement *)placement options:(NSDictionary *)options;
- (void) shouldHideMinimizedView;

// DataFrame Callbacks
- (NSDictionary *)onSwirlBridgeCallback:(NSDictionary *)data;

@end

