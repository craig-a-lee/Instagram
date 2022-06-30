//
//  ComposeViewController.h
//  Instagram
//
//  Created by Craig Lee on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"



NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didPost;

@end

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UITextView *caption;

@end

NS_ASSUME_NONNULL_END
