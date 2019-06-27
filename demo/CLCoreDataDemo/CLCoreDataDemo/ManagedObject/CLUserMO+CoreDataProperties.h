//
//  CLUserMO+CoreDataProperties.h
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/26.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import "CLUserMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CLUserMO (CoreDataProperties)

+ (NSFetchRequest<CLUserMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSString *secionId;
@property (nullable, nonatomic, retain) NSSet<CLCarMO *> *cars;
@property (nullable, nonatomic, retain) NSSet<CLHouseMO *> *houses;

@end

@interface CLUserMO (CoreDataGeneratedAccessors)

- (void)addCarsObject:(CLCarMO *)value;
- (void)removeCarsObject:(CLCarMO *)value;
- (void)addCars:(NSSet<CLCarMO *> *)values;
- (void)removeCars:(NSSet<CLCarMO *> *)values;

- (void)addHousesObject:(CLHouseMO *)value;
- (void)removeHousesObject:(CLHouseMO *)value;
- (void)addHouses:(NSSet<CLHouseMO *> *)values;
- (void)removeHouses:(NSSet<CLHouseMO *> *)values;

@end

NS_ASSUME_NONNULL_END
