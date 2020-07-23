//
//  Post.h
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/21/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface Post : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *speaker;
@property (nonatomic, assign) NSUInteger duration;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, copy) NSURL *imageURL;
@property (nonatomic, copy) NSURL *url;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
