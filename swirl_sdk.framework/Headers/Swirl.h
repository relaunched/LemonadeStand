// =====================================================================================================================
//  Swirl.h
//	Copyright (c) 2013-2015, Swirl Networks, Inc. All rights reserved.
// =====================================================================================================================

#import "SwirlDelegate.h"

typedef NSString *const SWUserStatus;
typedef NSString *const SWConfigStatus;

// =====================================================================================================================
// Network Status
// =====================================================================================================================

typedef enum {
    SWNetworkStatusNone		= 0,    // No network connectivity
    SWNetworkStatusWIFI		= 1,    // Connected via WIFI
    SWNetworkStatusWWAN		= 2     // Connected via WWAN (3G/4G/LTE)
} SWNetworkStatus;


// =====================================================================================================================
// Swirl SDK
// =====================================================================================================================
// For additional details, please consult the documentation accompanying the SDK

@interface Swirl : NSObject

@property (readonly)       NSString *      version;         // SDK version
@property (readonly)       SWNetworkStatus networkStatus;	// Network status
@property (readonly)       SWConfigStatus  locationStatus;	// Location services status
@property (readonly)       SWConfigStatus  bluetoothStatus; // Bluetooth services status
@property (readonly)       BOOL            scanning;		// Is BLE scanning for SecureCast beacons
@property (assign)         SWUserStatus    userStatus;		// User opt-in status
@property (strong, atomic) NSDictionary *  userInfo;		// User properties (any PII must be encrypted)
@property (strong, atomic) CLLocation *    location;		// Current location

+ (Swirl *)shared;                                          // Singleton accessor


// =====================================================================================================================
// *** Minimum Integration Requirements *** (see SDK User Guide for details)
// =====================================================================================================================

// Mimimum iOS base SDK: iOS 8.0, required to support devices running iOS 8.0+
// Minimum iOS deployment target: iOS 7.0

// App's build target:
// - "Build Phases" tab, "Link Binary With Libraries" section: include Swirl framework & iOS frameworks CoreLocation, CoreBluetooth, SystemConfiguration, Security
// - "Capabilities" tab, "Background Modes" section: ensure section is ON & "Uses Bluetooth LE accessories" is checked
// App's Info-plist:
// - For iOS8 location services, add "NSLocationAlwaysUsageDescription" with a user-visible usage description. See CLLocationManager.

// Initialization and startup, ** MUST BE CALLED ** in application:didFinishLaunchingWithOptions: to function properly
// Application key is required (obtained from the Swirl Marketing Console), delegate & options are optional
- (void) startWithDelegate:(id<SWDelegate>)delegate key:(NSString *)applicationKey options:(NSDictionary *)options;

// Local notification support, must be called in application:didReceiveLocalNotification:
- (BOOL) showContentForNotification:(UILocalNotification *)note;


// =====================================================================================================================
// Optional
// =====================================================================================================================

// Forces the Swirl SDK content WebView to show with the user's current content.
// UI related and should only be called from main thread.
- (void) showContent;

// Hides the Swirl SDK content WebView as soon as possible. Called internally when user dismisses the WebView.
// UI related and should only be called from main thread.
- (void) hideContent;

// Allow/prevent the Swirl SDK from automatically showing the content WebView for new content.
// UI related and should only be called from main thread.
- (void) showContentAutomatically:(BOOL)yn;

// Customize the 'minimized view' displayed when full-screen content is minimized, app in portrait orientation, and feature is enabled for the app from the console.
// UI related and should only be called from main thread. Recommend calling from viewWillAppear/Disappear and specifying SWMinimizedParent.
- (void) setMinimizedAllowed:(BOOL)allowed options:(NSDictionary *)options;

// An app that constructs/manages it's own minimized-UI should call this for the UI's show-content action
// UI related and should only be called from main thread.
// See SwirlDelegate's shouldShowMinimizedViewForLocation:options:
- (void) showContentForMinimized;

// Allow content to be shared to text, facebook or twitter (options controlled by iOS).
// UI related and should only be called from main thread.
- (void) shareContent:(NSString *)url title:(NSString*)title;

// Get the current value of a Swirl SDK option for customizing behavior. Primitives (numbers/BOOLs) returned as NSNumber.
- (id)	 optionForKey:(id)key;

// Set Swirl SDK options for customizing behavior. Expects NSNumbers for primitives (numbers/BOOLs).
// See startWithDelegate:key:options:
- (void) setOptions:(NSDictionary *)options;

// Stops the Swirl SDK and all associated services. ***TYPICALLY NOT USED*** since SDK can run in background and wake/launch for beacons, even after suspend/kill.
- (void) stop;

@end


// =====================================================================================================================
// User Status            :   User opt-in status
// =====================================================================================================================

extern NSString *const SWUserStatusUnknown;             // User not yet asked
extern NSString *const SWUserStatusOk;                  // Opted-in
extern NSString *const SWUserStatusDeferred;            // Opted-out but can ask again in future
extern NSString *const SWUserStatusDeniedContent;       // Opted-out
extern NSString *const SWUserStatusDenied;              // Opted-out and SDK won't use Bluetooth/location services


// =====================================================================================================================
// Config Status          :   Authorization status for services like location/Bluetooth
// =====================================================================================================================

extern NSString *const SWConfigStatusUnknown;
extern NSString *const SWConfigStatusOk;
extern NSString *const SWConfigStatusDenied;
extern NSString *const SWConfigStatusError;
extern NSString *const SWConfigStatusNotCapable;


// =====================================================================================================================
// Options                :   Optional parameters for customization of SDK behavior
// =====================================================================================================================

extern NSString *const SWOptionUseIDFA;                 // Allow SDK to access advertisingIdentifier (if AdSupport linked), default @YES
extern NSString *const SWOptionUseIDFV;					// Allow SDK to access identifierForVendor, default @YES
extern NSString *const SWOptionShowLocationDialog;      // Allow SDK to prompt user for location services auth, default @YES
extern NSString *const SWOptionShowNotificationDialog;  // Allow SDK to prompt user for local notification auth (iOS8), default @YES
extern NSString *const SWOptionScanMode;                // Bluetooth scan mode, default @SWScanIfAuthorized

typedef enum {                                          // Bluetooth Low Energy scan when:
    SWScanIfAuthorized = 1,                             // Bluetooth on & location authorized
    SWScanIfNotDetermined,                              // Bluetooth on & location authorized/not-determined
    SWScanAlways                                        // Bluetooth on (regardless of location services)
} SWScanMode;


// =====================================================================================================================
// User Info              :   Common keys for optional user profile info
// =====================================================================================================================

extern NSString *const SWUserInfoGender;                // NSString  (@"male" | @"female")
extern NSString *const SWUserInfoBirthday;              // NSString  (format: @"YYYY-MM-DD")


// =====================================================================================================================
// Minimized View Options :   Optional parameters for customization of Minimized View
// =====================================================================================================================
// See setMinimizedAllowed:options: & SwirlDelegate shouldShowMinimizedViewForLocation:options:

extern NSString *const SWMinimizedParent;               // UIView/UIViewController  Display view-parent. SDK will only keep weak reference.  Only set via setMinimizedAllowed:options:
extern NSString *const SWMinimizedOrigin;               // NSString                 Display origin. See NSStringFromCGPoint()
extern NSString *const SWMinimizedWidth;                // NSNumber double          Width, defaults to screen/parent width
extern NSString *const SWMinimizedHeight;               // NSNumber double          Height, defaults to 44 (88 retina)
extern NSString *const SWMinimizedBackgroundColor;      // NSString                 Background color, defaults to translucent-black, or clear if SWMinimizedImage found
extern NSString *const SWMinimizedImage;                // NSString                 Filename of app image resource to use as background image (loaded by imageWithName:)
extern NSString *const SWMinimizedExpandImage;          // NSString                 Filename of app image resource to use as expand icon
extern NSString *const SWMinimizedExpandText;           // NSString                 Expand text, used if no image found, defaults to @"▲", set to @"" to eliminate
extern NSString *const SWMinimizedLabelText;            // NSString                 Label text, default varies with store location, set to @" " to eliminate
extern NSString *const SWMinimizedLabelTextColor;       // NSString                 Label text color, ie @"#66066", defaults to white


