//
//  CLCoreDateManager.h
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/24.
//  Copyright © 2019年 周冯婷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLCoreDateManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic, strong, readonly) NSManagedObjectContext *mainContext;

- (void)cl_saveMainContext;

- (NSManagedObjectContext *)cl_newBackgroundContext;

- (void)cl_performBackgroundTask:(void (^)(NSManagedObjectContext * privateContext))block;

@end

NS_ASSUME_NONNULL_END
