//
//  AllVideoViewController.m
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/21/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "AllVideoViewController.h"
#import "Loader.h"
#import "Post.h"
#import "PostTableViewCell.h"
#import "DetailViewController.h"
#import "Post.h"



@interface AllVideoViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<Post*>  *dataSource;
@property (nonatomic, strong) Loader *loader;
@property (nonatomic, strong) UIView *containerSearchView;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation AllVideoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTableView];
    [self setupSearchController];
    [self makeConstraints];
    self.loader = [Loader new];
    [self loadPosts];
    
}
- (void)setupSearchController{
    
    self.searchController = [[UISearchController alloc] init];
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    
    self.containerSearchView = [UIView new];
    [self.view addSubview:self.containerSearchView];
    [self.containerSearchView addSubview:self.searchController.searchBar];
    self.searchController.searchBar.delegate = self;
    
}
- (void)setupTableView{
    
    self.tableView  = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:PostTableViewCell.class forCellReuseIdentifier:@"CellID"];
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = 80;
    
}
- (void)makeConstraints{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerSearchView.translatesAutoresizingMaskIntoConstraints = NO;
    self.searchController.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.containerSearchView.bottomAnchor constant:5],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        
    ]];
    
    
}
- (void) loadPosts{
    
    __weak typeof(self) weakSelf = self;
    [self.loader loadPostsWithCompletion:^(NSArray<Post *> *posts, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                weakSelf.dataSource = posts;
                [weakSelf.tableView reloadData];
            }
        });
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    [cell setupCellWithPost: self.dataSource[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailViewControler = [DetailViewController new];
    detailViewControler.post = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detailViewControler animated:YES];
}

- (void)filterCurentDataSource: (NSString *) searchTerm{
    
}


- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

@end
