//
//  DetailViewController.h
//  Instagram
//
//  Created by Kobe Petrus on 7/9/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
