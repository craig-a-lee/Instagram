//
//  FeedViewController.m
//  Instagram
//
//  Created by Craig Lee on 6/27/22.
//

#import "FeedViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "ComposeViewController.h"
#import "PostCell.h"
#import "DetailViewController.h"
@interface FeedViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, DetailViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self getTimeline];
}
- (IBAction)didTapLogOut:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        
    }];
}


- (void)getTimeline{
    // Get timeline
    // if ([self.navigationController.restorationIdentifier isEqualToString:@"TimelineNavController"]) {
        PFQuery *postQuery = [Post query];
        [postQuery orderByDescending:@"createdAt"];
        [postQuery includeKey:@"author"];
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
//    } else {
//        PFQuery *postQuery = [Post query];
//        [postQuery orderByDescending:@"createdAt"];
//        [postQuery includeKey:@"author"];
//        [postQuery whereKey:@"likesCount" greaterThan:@100];
//        postQuery.limit = 20;
//
//        // fetch data asynchronously
//        [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
//            if (posts) {
//                // do something with the data fetched
//                self.arrayOfPosts = (NSMutableArray *) posts;
//                [self.tableView reloadData];
//                [self.refreshControl endRefreshing];
//            }
//            else {
//                // handle error
//            }
//        }];
//    }
}

- (void) didPost {
    //[self.arrayOfTweets addObject:tweet];
    //[self.arrayOfPosts insertObject:post atIndex:0];
    [self getTimeline];
    //[self.tableView reloadData];
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

- (void)didClickPost:(NSIndexPath *)postPath {
    //PostCell *cell = [self.tableView cellForRowAtIndexPath:postPath];
    [self.tableView reloadData];
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
        Post *dataToPass = self.arrayOfPosts[myIndexPath.row];
        DetailViewController *detailVC = [segue destinationViewController];
        detailVC.detailPost = dataToPass;
        detailVC.delegate = self;
        detailVC.path = myIndexPath;
    } else if ([segue.identifier isEqualToString:@"composeSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *controller = (ComposeViewController *) navigationController.topViewController;
        controller.delegate = self;
    }
}


@end
