//
//  DetailViewController.m
//  Instagram
//
//  Created by Kobe Petrus on 7/9/21.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Parse/Parse.h"
#import "DateTools.h"
#import "Post.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postView;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFFileObject *postImage = _post[@"image"]; // set your column name from Parse here
    NSURL * imageURL = [NSURL URLWithString:postImage.url];
    [self.postView setImageWithURL:imageURL];
    
    self.captionLabel.text = self.post.caption;
    NSString *stringDate = self.post.createdAt.description;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    NSDate *dateDate = [formatter dateFromString:stringDate];
    
    self.timestampLabel.text = dateDate.shortTimeAgoSinceNow;

    

    
    // Do any additional setup after loading the view.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
