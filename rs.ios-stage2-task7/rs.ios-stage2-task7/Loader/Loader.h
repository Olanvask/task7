//
//  Loader.h
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Loader : NSObject
- (void)loadPostsWithCompletion:(void (^)(NSArray *, NSError *))completion;
- (void)loadImageWithURL: (NSURL *) url completion:(void (^)(UIImage *, NSError *))completion;
@end

NS_ASSUME_NONNULL_END
