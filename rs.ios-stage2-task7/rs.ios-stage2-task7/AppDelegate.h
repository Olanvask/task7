//
//  AppDelegate.h
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/21/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

