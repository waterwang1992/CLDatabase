//
//  CLUserMO+CoreDataClass.m
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/26.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import "CLUserMO+CoreDataClass.h"

@implementation CLUserMO

+ (instancetype)userWithUserId:(NSString *)userId userName:(NSString *)userName inContext:(NSManagedObjectContext *)context{
    
    CLUserMO *user = nil;
    if (context == nil) {
        return user;
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CLUser"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"userId" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"userId", userId];
    
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:request error:&fetchError];
    if (fetchError) {
        NSLog(@"fetch error: %@", [fetchError localizedDescription]);
    }
    
    user = [result firstObject];
    
    if (!user) {
        user = [[CLUserMO alloc] initWithEntity:[NSEntityDescription entityForName:@"CLUser" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        user.userId = userId;
        user.userName = userName;
        user.secionId = [userName substringToIndex:1];
    }
    return user;
}

+ (NSString *)maxUserIdInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CLUser"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"userId" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:request error:&fetchError];
    if (fetchError) {
        NSLog(@"fetch error: %@", [fetchError localizedDescription]);
    }
    CLUserMO *user = result.lastObject;
    return user.userId;
}

@end
