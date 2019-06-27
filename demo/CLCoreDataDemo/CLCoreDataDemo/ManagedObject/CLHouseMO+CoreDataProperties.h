//
//  CLHouseMO+CoreDataProperties.h
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/26.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import "CLHouseMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CLHouseMO (CoreDataProperties)

+ (NSFetchRequest<CLHouseMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *houseId;
@property (nullable, nonatomic, retain) CLUserMO *user;

@end

NS_ASSUME_NONNULL_END
