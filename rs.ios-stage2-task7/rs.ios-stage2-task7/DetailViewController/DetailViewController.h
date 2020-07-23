//
//  DetailViewController.h
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic, strong) Post *post;
@end

NS_ASSUME_NONNULL_END
