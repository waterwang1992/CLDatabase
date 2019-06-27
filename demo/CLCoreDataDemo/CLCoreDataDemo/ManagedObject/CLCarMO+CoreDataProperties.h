//
//  CLCarMO+CoreDataProperties.h
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/26.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import "CLCarMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CLCarMO (CoreDataProperties)

+ (NSFetchRequest<CLCarMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *carBrand;
@property (nullable, nonatomic, copy) NSString *carId;
@property (nullable, nonatomic, retain) CLUserMO *user;

@end

NS_ASSUME_NONNULL_END
