//
//  CLCoreDateManager.m
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/24.
//  Copyright © 2019年 周冯婷. All rights reserved.
//

#import "CLCoreDateManager.h"

@interface CLCoreDateManager ()
@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation CLCoreDateManager

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static CLCoreDateManager *coreDataManager = nil;
    dispatch_once(&onceToken, ^{
        coreDataManager = [[CLCoreDateManager alloc] init];
    });
    return coreDataManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - 初始化

- (void)setup {
    [self setupCoreDataStack];
}

- (void)setupCoreDataStack {
    NSPersistentStoreCoordinator *persistentStoreCoordinator = self.persistentStoreCoordinator;
    _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_mainContext setPersistentStoreCoordinator:persistentStoreCoordinator];
}

#pragma mark - coredata stack

/**
 The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CLCoredata.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    NSDictionary *migrationOptions = @{NSMigratePersistentStoresAutomaticallyOption:@(YES), NSInferMappingModelAutomaticallyOption:@(YES)};
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:migrationOptions error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"good store: %@", _persistentStoreCoordinator);
    return _persistentStoreCoordinator;

}

/**
The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CLCoreData" withExtension:@"momd"];
    NSLog(@"%@", modelURL.path);
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/**
 数据库文件夹路径
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - public

- (void)cl_saveMainContext{
    if (_mainContext == nil) {
        return;
    }
    [_mainContext performBlock:^{
        if ([self.mainContext hasChanges]) {
            NSError *error = nil;
            if (![self.mainContext save:&error]) {
                [self.mainContext rollback];
            }else{
                NSLog(@"save main success");
            }
        }
    }];
}

- (NSManagedObjectContext *)cl_newBackgroundContext {
    if (_mainContext == nil) return nil;
    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [privateContext setParentContext:_mainContext];
    return privateContext;
}

- (void)cl_performBackgroundTask:(void (^)(NSManagedObjectContext * _Nonnull))block {
    NSManagedObjectContext *privateContext = [self cl_newBackgroundContext];
    NSLog(@"%@", [NSThread currentThread]);
    [privateContext performBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
        if (block) {
            block(privateContext);
        }
    }];
}

@end
