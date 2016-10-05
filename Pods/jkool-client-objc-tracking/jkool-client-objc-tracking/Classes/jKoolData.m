#import "jKoolData.h"

@implementation jKoolData

@synthesize vc;
@synthesize token;
@synthesize activity;
@synthesize activityName;
@synthesize location;
@synthesize jkStreaming;
@synthesize applicationName;
@synthesize dataCenter;
@synthesize resource;
@synthesize ssn;
@synthesize correlators;
@synthesize connectionType;
@synthesize ipAddress;
@synthesize enableActions;
@synthesize enableErrors;
@synthesize onlyIfWifi;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static jKoolData *jk = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jk = [[self alloc] init];
    });
    return jk;
}

- (id)init {
    if (self = [super init]) {
        token = @"Default Property Value";
    }
    return self;
}

- (void)dealloc {
}

@end
