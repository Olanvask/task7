//
//  XMLParser.h
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLParser : NSObject
- (void) parseData: (NSData *) data completion:(void (^)(NSArray<Post *> *, NSError *))completion;
@end

NS_ASSUME_NONNULL_END
