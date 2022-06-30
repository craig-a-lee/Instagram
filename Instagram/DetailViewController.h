//
//  DetailViewController.h
//  Instagram
//
//  Created by Craig Lee on 6/29/22.
//

#import "ViewController.h"
#import "Post.h"
#import "Parse/Parse.h"
@import Parse;



NS_ASSUME_NONNULL_BEGIN

@protocol DetailViewControllerDelegate

- (void)didClickPost:(NSIndexPath *)postPath;


@end

@interface DetailViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *likesCount;
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet PFImageView *picture;
@property (strong, nonatomic) Post *detailPost;
@property (nonatomic, weak) id<DetailViewControllerDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *path;

@end

NS_ASSUME_NONNULL_END
