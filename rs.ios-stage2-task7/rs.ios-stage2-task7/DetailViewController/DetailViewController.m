//
//  DetailViewController.m
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "DetailViewController.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"
#import "AppDelegate.h"
#import "PostInCoreData+CoreDataProperties.h"

@interface DetailViewController ()
@property (nonatomic, strong) AVPlayer *videoPlayer;
@property (nonatomic, strong) AVPlayerViewController *videoPlayerController;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *shareButton;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVideoPlayer];
    [self setupLikeButon];
    [self setupShareButton];
    [self makeConstraints];
}

- (void)setupVideoPlayer{
    
    self.videoPlayer = [AVPlayer playerWithURL:self.post.videoURL];
    self.videoPlayerController = [[AVPlayerViewController alloc] init];
    
    [self addChildViewController: self.videoPlayerController];
    [self.view addSubview:self.videoPlayerController.view];
    
    self.videoPlayerController.player = self.videoPlayer;
    self.videoPlayerController.showsPlaybackControls = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    if ([self fetchPostInCoreData]) {
        self.likeButton.backgroundColor = UIColor.darkGrayColor;
    }
}

- (PostInCoreData *)fetchPostInCoreData{
    
    NSArray *fetchedObjects;
    NSManagedObjectContext *context = [self viewContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"PostInCoreData"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@",self.post.title];
    [fetchRequest setPredicate:predicate];
    
    fetchedObjects = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if (fetchedObjects) {
        return fetchedObjects.firstObject;
    }
    
    return nil;
}

- (void)setupLikeButon{
    
    self.likeButton = [[UIButton alloc] init];
    [self.likeButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    if ([self fetchPostInCoreData]) {
        [self.likeButton setSelected:YES];
        
    }else{
        [self.likeButton setSelected:NO];
        
    }
    [self.likeButton setTitle:@"Add to Favorites" forState:UIControlStateNormal];
    [self.likeButton setTitle:@"Delete from Favorites" forState:UIControlStateSelected];
    [self.view addSubview:self.likeButton];
    [self.likeButton addTarget:self
                        action:@selector(likeButtonTaped)
              forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupShareButton{
    
    self.shareButton = [UIButton new];
    [self.shareButton setTitle:@"Share" forState:UIControlStateNormal];
    [self.shareButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareButton];
    
}

- (void)makeConstraints{
    
    self.videoPlayerController.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.likeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.videoPlayerController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.videoPlayerController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.videoPlayerController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.videoPlayerController.view.heightAnchor constraintGreaterThanOrEqualToAnchor:self.videoPlayerController.view.widthAnchor multiplier: 0.8],
        
        [self.shareButton.topAnchor constraintEqualToAnchor:self.videoPlayerController.view.bottomAnchor constant: 10],
        [self.shareButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: 5],
        [self.shareButton.widthAnchor constraintEqualToAnchor:self.videoPlayerController.view.widthAnchor multiplier: 0.5],
        [self.shareButton.heightAnchor constraintEqualToConstant:50],
        
        [self.likeButton.topAnchor constraintEqualToAnchor:self.videoPlayerController.view.bottomAnchor constant: 10],
        [self.likeButton.widthAnchor constraintEqualToAnchor:self.videoPlayerController.view.widthAnchor multiplier: 0.5],
        [self.likeButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:5],
        
        [self.likeButton.heightAnchor constraintEqualToConstant:50],
    ]];
}

- (void)likeButtonTaped{
    
    if ([self fetchPostInCoreData]) {
        
        NSManagedObjectContext *context = [self viewContext];
        [context deleteObject:[self fetchPostInCoreData]];
        
        [self.likeButton setSelected:NO];
        
    }else{
        
        NSManagedObjectContext *context = [self viewContext];
        PostInCoreData *postInCoreData = [[PostInCoreData alloc] initWithContext:context];
        postInCoreData.descr = self.post.description;
        postInCoreData.duration = self.post.duration;
        postInCoreData.title = self.post.title;
        postInCoreData.imageURL = self.post.imageURL.absoluteString;
        postInCoreData.videoURL = self.post.videoURL.absoluteString;
        NSError *error = nil;
        
        [context save:&error];
        
        [self.likeButton setSelected:YES];
    }
}

- (void)shareButtonTaped{
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                        initWithActivityItems:@[self.post.url]
                                                        applicationActivities:nil];
    activityViewController.modalPresentationStyle = UIModalPresentationPopover;
    activityViewController.popoverPresentationController.sourceView = self.shareButton;
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}

- (NSManagedObjectContext *)viewContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.viewContext;
}

@end
