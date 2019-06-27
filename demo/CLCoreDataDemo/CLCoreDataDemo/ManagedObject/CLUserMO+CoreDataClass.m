//
//  CLUserMO+CoreDataClass.m
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/26.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import "CLUserMO+CoreDataClass.h"

NSString *const CLCoreData_EntityName_User = @"CLUser";
NSString *const CLCoreData_PropertyName_UserId = @"userId";
NSString *const CLCoreData_PropertyName_SecionId = @"secionId";

@implementation CLUserMO

+ (instancetype)userWithUserId:(NSInteger)userId userName:(NSString *)userName inContext:(NSManagedObjectContext *)context{
    
    CLUserMO *user = nil;
    if (context == nil) {
        return user;
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLCoreData_EntityName_User];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:CLCoreData_PropertyName_UserId ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"%K = %ld", CLCoreData_PropertyName_UserId, userId];
    
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:request error:&fetchError];
    if (fetchError) {
        NSLog(@"fetch error: %@", [fetchError localizedDescription]);
    }
    
    user = [result firstObject];
    
    if (!user) {
        user = [[CLUserMO alloc] initWithEntity:[NSEntityDescription entityForName:CLCoreData_EntityName_User inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        user.userId = userId;
        user.userName = userName;
        user.secionId = [userName substringToIndex:1];
    }
    return user;
}

+ (NSInteger)maxUserIdInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLCoreData_EntityName_User];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:CLCoreData_PropertyName_UserId ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:request error:&fetchError];
    if (fetchError) {
        NSLog(@"fetch error: %@", [fetchError localizedDescription]);
    }
    CLUserMO *user = result.lastObject;
    return user.userId;
}

@end
