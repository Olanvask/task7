//
//  postTableViewCell.m
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "PostTableViewCell.h"
#import "Post.h"
#import "Loader.h"
#import "PostInCoreData+CoreDataProperties.h"

@interface PostTableViewCell();
@property (nonatomic, strong) Post *post;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *speakerLabel;
@property (nonatomic, strong) UIImageView *postImageView;


@end

@implementation PostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupCellWithPost: (Post *) post{
    
    self.post = post;
    
    [self setupLabels];
    [self setupImage];
    [self makeConstraints];
    
}
- (void)setupCellWithPostInCoreData: (PostInCoreData *) post{
    
    self.post = [Post new];
    self.post.title = post.title;
    self.post.imageURL = [NSURL URLWithString: post.imageURL];
    
    [self setupLabels];
    [self setupImage];
    [self makeConstraints];
    
}
- (void)setupLabels{
    
    self.speakerLabel = [UILabel new];
    self.speakerLabel.text = self.post.speaker;
    [self addSubview:self.speakerLabel];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.text = self.post.title;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:self.titleLabel];
    
}
- (void)setupImage{
    
    self.postImageView = [UIImageView new];
    [self addSubview:self.postImageView];
    
    Loader *loader = [Loader new];
    __weak typeof(self) weakSelf = self;
    [ loader loadImageWithURL:self.post.imageURL completion:^(UIImage *image, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [weakSelf.postImageView setImage:image];
            }
        });
    }];
    self.postImageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)makeConstraints{
    self.postImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.speakerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.postImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant: 5],
        [self.postImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier: 0.4],
        [self.postImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant: 5],
        [self.postImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant: -5],
        
        [self.speakerLabel.leadingAnchor constraintEqualToAnchor:self.postImageView.trailingAnchor constant: 5],
        [self.speakerLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: 5],
        [self.speakerLabel.topAnchor constraintEqualToAnchor:self.postImageView.topAnchor constant: 5],
        //      [self.speakerLabel.heightAnchor constraintEqualToConstant: 100],
        
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.postImageView.trailingAnchor constant: 5],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: 5],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.speakerLabel.bottomAnchor constant: 5],
        [self.titleLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.bottomAnchor constant: -5],
    ]];
}
- (void)prepareForReuse{
    [super prepareForReuse];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
