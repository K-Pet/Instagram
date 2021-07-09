//
//  TimelineViewController.m
//  Instagram
//
//  Created by Kobe Petrus on 7/7/21.
//

#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "PostsCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"
#import "DateTools.h"
@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;
@property (strong, nonatomic) NSArray *arrayOfPosts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postsTableView.dataSource = self;
    self.postsTableView.delegate = self;
    
    [self fetchPosts];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.postsTableView insertSubview:self.refreshControl atIndex:0];
    [self.postsTableView addSubview:self.refreshControl];

}

- (void) fetchPosts{
    // construct PFQuery
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post"];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts) {
            self.arrayOfPosts = posts;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            [self.postsTableView reloadData];
        }
        else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCell" forIndexPath:indexPath];
    
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.authorLabel.text = post.author.username;
    cell.captionLabel.text = post.caption;
    NSNumber* commentValue = post[@"commentCount"];
    cell.commentsCountLabel.text = [commentValue stringValue];
    NSNumber* likesValue = post[@"likeCount"];
    cell.likesCountLabel.text = [[likesValue stringValue] stringByAppendingString: @" Likes"];
    PFFileObject *postImage = post[@"image"]; // set your column name from Parse here
    NSURL * imageURL = [NSURL URLWithString:postImage.url];
    [cell.postImageView setImageWithURL:imageURL];
    NSString *stringDate = post.createdAt.description;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    NSDate *dateDate = [formatter dateFromString:stringDate];
    
    cell.createdAtLabel.text = dateDate.shortTimeAgoSinceNow;
   
    return cell;
     
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.postsTableView indexPathForCell:tappedCell];
    NSDictionary *post = self.arrayOfPosts[indexPath.row];

    
    DetailViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.post = post;
    // Pass the selected object to the new view controller.
}






@end
