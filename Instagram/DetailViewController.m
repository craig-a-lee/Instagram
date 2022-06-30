//
//  DetailViewController.m
//  Instagram
//
//  Created by Craig Lee on 6/29/22.
//

#import "DetailViewController.h"
#import "DateTools.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setParams:self.detailPost];
}

- (void) setParams:(Post *)detailPost {
    self.username.text = detailPost.author.username;
    self.caption.text = detailPost.caption;
    self.picture.file = detailPost[@"image"];
    NSLog(@"Here %@", self.picture.file);
    [self.picture loadInBackground];
    self.timestamp.text = detailPost.createdAt.shortTimeAgoSinceNow;
    self.likesCount.text = [NSString stringWithFormat:@"%@", detailPost.likeCount];
    self.commentsCount.text = [NSString stringWithFormat:@"%@", detailPost.commentCount];
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
