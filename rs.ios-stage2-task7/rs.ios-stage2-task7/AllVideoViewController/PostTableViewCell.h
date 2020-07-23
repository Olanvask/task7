//
//  postTableViewCell.h
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PostInCoreData+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostTableViewCell : UITableViewCell
//@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, strong) UILabel *titleLabel;
- (void)setupCellWithPost: (Post *) post;
- (void)setupCellWithPostInCoreData: (PostInCoreData *) post;
@end

NS_ASSUME_NONNULL_END
