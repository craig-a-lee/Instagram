//
//  ProfileViewController.m
//  Instagram
//
//  Created by Craig Lee on 6/29/22.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "PostCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ProfileViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self getTimeline];
}

- (void)getTimeline {
    // Get timeline
    // if ([self.navigationController.restorationIdentifier isEqualToString:@"TimelineNavController"]) {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:PFUser.currentUser];
    postQuery.limit = 20;
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.arrayOfPosts = (NSMutableArray *) posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else {
            // handle error
        }
    }];
    self.username.text = PFUser.currentUser.username;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView /*next time use MovieCell as variable name*/ dequeueReusableCellWithIdentifier:@"PostCell"];
    
    //cell.tweet = self.arrayOfTweets[indexPath.row];
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.post = post;
    
    //cell.commentCount.text = post.t
    [cell setPost:cell.post];
    return cell;
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    // Create NSURL and NSURLRequest
    [self getTimeline];
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
