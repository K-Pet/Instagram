//
//  PhotoViewController.m
//  Instagram
//
//  Created by Kobe Petrus on 7/7/21.
//

#import "PhotoViewController.h"
#import "Post.h"
#import "AppDelegate.h"


@interface PhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextField *captionTextView;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Put to `viewDidload`
    AppDelegate* shared=[UIApplication sharedApplication].delegate;
    shared.blockRotation=YES;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    AppDelegate* shared=[UIApplication sharedApplication].delegate;
    shared.blockRotation=NO;
}
- (IBAction)chooseImageButton:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];


    // Do something with the images (based on your use case)
    self.postImageView.image = editedImage;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapPostButton:(id)sender {
    [Post postUserImage:self.postImageView.image withCaption: self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error posting image: %@", error.localizedDescription);
        }
        else{
            NSLog(@"image post Success!");
            [self.navigationController popViewControllerAnimated:YES];
        }
        
//        UIView *view = [[UIView alloc] initWithNibName:@"AuthenticatedViewController" bundle:nil];
//            [self.view addSubview:view];
        }];
}

@end
