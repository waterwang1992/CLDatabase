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

extern NSString *const CLCoreData_EntityName_User;
extern NSString *const CLCoreData_PropertyName_UserId;
extern NSString *const CLCoreData_PropertyName_SecionId;

NS_ASSUME_NONNULL_BEGIN

@interface CLUserMO : NSManagedObject

+ (instancetype)userWithUserId:(NSInteger)userId userName:(NSString *)userName inContext:(NSManagedObjectContext *)context;

+ (NSInteger)maxUserIdInContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "CLUserMO+CoreDataProperties.h"
