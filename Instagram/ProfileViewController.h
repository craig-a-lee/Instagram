//
//  ProfileViewController.h
//  Instagram
//
//  Created by Craig Lee on 6/29/22.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : ViewController
@property (nonatomic, strong) NSMutableArray *arrayOfPosts;
@property (weak, nonatomic) IBOutlet UILabel *username;

@end

NS_ASSUME_NONNULL_END
