#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
// 友盟统计sdk
#import <UMCommon/UMConfigure.h>
#import <UMCommon/MobClick.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  [self initAnalysisUM];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


-(void)initAnalysisUM{
    [UMConfigure setLogEnabled:YES];
    [UMConfigure initWithAppkey:@"61a07941e014255fcb8d32ac" channel:@"App Store"]; // 增加这行
}

@end
