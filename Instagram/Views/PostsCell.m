//
//  PostsCell.m
//  Instagram
//
//  Created by Kobe Petrus on 7/8/21.
//

#import "PostsCell.h"
#import "Post.h"
@implementation PostsCell


- (void)setPost:(Post *)post {
    self.post = post;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
}

@end
