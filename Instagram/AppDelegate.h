//
//  AppDelegate.h
//  Instagram
//
//  Created by Kobe Petrus on 7/6/21.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic , assign) bool blockRotation;

- (UIInterfaceOrientationMask)application:(UIApplication *)application       supportedInterfaceOrientationsForWindow:(UIWindow *)window;
@end

