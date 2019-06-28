//
//  ViewController.m
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/3/15.
//  Copyright © 2019年 周冯婷. All rights reserved.
//

#import "ViewController.h"
#import "CLCoreDateManager.h"
#import "CLUserMO+CoreDataClass.h"
@interface ViewController () <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSFetchedResultsController *feCtr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = CLCoreData_EntityName_User;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"batchCreat" style:UIBarButtonItemStylePlain target:self action:@selector(batchCreatUsers)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"clear" style:UIBarButtonItemStylePlain target:self action:@selector(clear)];
    [self setupView];
}

- (void)setupView {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, window.frame.size.width, window.frame.size.height - 100) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:_tableView];
    [self initializeFetchedResultsController];
}


- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLCoreData_EntityName_User];
    
    NSSortDescriptor *seciotnNameSort = [NSSortDescriptor sortDescriptorWithKey:CLCoreData_PropertyName_SecionId ascending:YES];
    NSSortDescriptor *userIdSort = [NSSortDescriptor sortDescriptorWithKey:CLCoreData_PropertyName_UserId ascending:YES];
    
    [request setSortDescriptors:@[seciotnNameSort, userIdSort]];
    request.predicate = nil;
    request.fetchLimit = 20;
    
    NSManagedObjectContext *moc = [CLCoreDateManager shareManager].mainContext; //Retrieve the main queue NSManagedObjectContext
    
    _feCtr = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:CLCoreData_PropertyName_SecionId cacheName:nil];
    _feCtr.delegate = self;
    
    NSError *error = nil;
    if (![_feCtr performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    CLUserMO *user = [self.feCtr objectAtIndexPath:indexPath];
    cell.textLabel.text = user.userName;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = _feCtr.sections[section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _feCtr.sections.count;
}

#pragma mark - UITableViewDelegate


-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.feCtr.sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.feCtr.sectionIndexTitles indexOfObject:title];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.feCtr.sections objectAtIndex:section];
   label.text = [sectionInfo name];
    return label;
}




#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] endUpdates];
}

#pragma mark - actions


#pragma mark - test

- (void)batchCreatUsers{

//    NSManagedObjectContext *mainContext =   CLCoreDateManager.shareManager.mainContext;
//    NSLog(@"%@", [NSThread currentThread]);
//    [mainContext performBlock:^{
//         NSLog(@"%@", [NSThread currentThread]);
//        [self batchCreatUserInContext:mainContext];
//    }];
//    return;

    
    [CLCoreDateManager.shareManager cl_performBackgroundTask:^(NSManagedObjectContext * _Nonnull privateContext) {
        
         NSLog(@"======== session begin, --thread:%@", [NSThread currentThread]);

//        [CLCoreDateManager.shareManager.mainContext performBlockAndWait:^{
//            NSLog(@"========  main 开始");
//           [self batchCreatUserInContext:CLCoreDateManager.shareManager.mainContext];
//            NSLog(@"========  main 结束");
//        }];
        
//        [privateContext performBlockAndWait:^{
//            NSLog(@"======== private session_1 begin, --thread:%@", [NSThread currentThread]);
//            [self batchCreatUserInContext:privateContext];
//            NSLog(@"======== private session_1 end, --thread:%@", [NSThread currentThread]);
//        }];
        
        [privateContext performBlockAndWait:^{
            NSLog(@"======== private session_2 begin, --thread:%@", [NSThread currentThread]);
            [self batchCreatUserInContext:privateContext];
            NSLog(@"======== private session_2 end, --thread:%@",[NSThread currentThread]);
        }];
        
        NSLog(@"======== session end, --thread:%@", [NSThread currentThread]);
        
        [CLCoreDateManager.shareManager cl_saveMainContext];
    }];
    
}

- (void)batchCreatUserInContext:(NSManagedObjectContext *)context {
    NSInteger maxId = [CLUserMO maxUserIdInContext:context];
    for (NSInteger i = maxId + 1; i < maxId + 101; i++) {
        NSString *randomName = [NSString stringWithFormat:@"%@_userName_%ld", [self randomSectionStr], i];
        [CLUserMO userWithUserId:i userName:randomName inContext:context];
        [context save:nil];
    };
}

- (NSString *)randomSectionStr {
    int figure = (arc4random() % 26) + 97;
    char character = figure;
    return [NSString stringWithFormat:@"%c", character];
}

- (void)clear {
    NSManagedObjectContext *context = [CLCoreDateManager shareManager].mainContext;
    //1.创建查询请求 EntityName：想要清楚的实体的名字
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:CLCoreData_EntityName_User];
    
   NSArray *result = [context executeFetchRequest:request error:nil];
    
    for (id obj in result) {
        [context deleteObject:obj];
    }
    
    [CLCoreDateManager.shareManager cl_saveMainContext];
    
    
}

- (void)newBatchDelete {
    NSManagedObjectContext *context = [CLCoreDateManager shareManager].mainContext;
    //1.创建查询请求 EntityName：想要清楚的实体的名字
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:CLCoreData_EntityName_User];
    
    //2.创建删除请求  参数是：查询请求
    //NSBatchDeleteRequest是iOS9之后新增的API，不兼容iOS8及以前的系统
    NSBatchDeleteRequest *deletRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    //3.使用存储调度器(NSPersistentStoreCoordinator)执行删除请求
    /**
     Request：存储器请求（NSPersistentStoreRequest）  删除请求NSBatchDeleteRequest继承于NSPersistentStoreRequest
     context：管理对象上下文
     */
    NSError *error = nil;
    [context.persistentStoreCoordinator executeRequest:deletRequest withContext:context error:&error];
    if (error) {
        NSLog(@"batch delete users error ,%@", error);
    }
    [[CLCoreDateManager shareManager] cl_saveMainContext];
}


@end
