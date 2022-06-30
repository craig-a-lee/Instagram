//
//  PostCell.m
//  Instagram
//
//  Created by Craig Lee on 6/28/22.
//

#import "PostCell.h"
#import "Post.h"
#import "DateTools.h"
@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
// Since we're replacing the default setter, we have to set the underlying private storage _movie ourselves.
// _movie was an automatically declared variable with the @propery declaration.
// You need to do this any time you create a custom setter.

    _post = post;
    self.author.text = post.author.username;
    
    self.caption.text = post.caption;
    self.likeCount.text = [NSString stringWithFormat:@"%@", post.likeCount];
    self.commentCount.text = [NSString stringWithFormat:@"%@", post.commentCount];
    //self.
    self.picture.file = post[@"image"];
    NSLog(@"Here %@", self.picture.file);
    [self.picture loadInBackground];
    self.timeStamp.text = post.createdAt.shortTimeAgoSinceNow;
    
//    self.author.text = [NSString stringWithFormat:@"%i", post.author];
//    self.caption.text = post.caption;
//    self.likeCount.text = post.likeCount;
//    self.commentCount.text = post.commentCount;
}

@end
