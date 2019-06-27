//
//  CLUserMO+CoreDataClass.h
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/26.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CLCarMO, CLHouseMO;

NS_ASSUME_NONNULL_BEGIN

@interface CLUserMO : NSManagedObject

+ (instancetype)userWithUserId:(NSString *)userId userName:(NSString *)userName inContext:(NSManagedObjectContext *)context;

+ (NSString *)maxUserIdInContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "CLUserMO+CoreDataProperties.h"
