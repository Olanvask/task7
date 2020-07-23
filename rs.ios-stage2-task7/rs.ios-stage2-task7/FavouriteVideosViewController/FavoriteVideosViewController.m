//
//  FavoriteVideosViewController.m
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/23/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "FavoriteVideosViewController.h"
#import "Post.h"
#import "PostInCoreData+CoreDataClass.h"
#import "PostInCoreData+CoreDataProperties.h"
#import "PostTableViewCell.h"
#import "AppDelegate.h"

@interface FavoriteVideosViewController ()<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<PostInCoreData*> *dataSource;
@property (nonatomic) NSFetchedResultsController *frc;

@end

@implementation FavoriteVideosViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTableView];
    [self makeConstraints];
    
    [self viewContext].automaticallyMergesChangesFromParent = YES;
    
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:[PostInCoreData fetchRequest] managedObjectContext:[self viewContext] sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;
}

- (void)setupTableView{
    
    self.tableView  = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:PostTableViewCell.class forCellReuseIdentifier:@"CellID"];
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = 80;}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.frc performFetch:nil];
    
}

- (void)makeConstraints{
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    [cell setupCellWithPostInCoreData: self.frc.fetchedObjects[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.frc.fetchedObjects.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSManagedObjectContext *)viewContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.viewContext;
}

- (NSManagedObjectContext *)newBackgroundContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.newBackgroundContext;
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
