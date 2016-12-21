//
//  ViewController.m
//  SortDemo
//
//  Created by 董徐维 on 2016/11/1.
//  Copyright © 2016年 Mr.Tung. All rights reserved.
//

#import "ViewController.h"

#import "Obj.h"

@interface ViewController ()
{
    NSMutableArray *unSortedArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    unSortedArray = [NSMutableArray new];
    //    for(NSInteger i = 0; i <1000000;i++)
    //    {
    //        Obj *obj = [Obj new];
    //        obj.ID = arc4random() % 1000000;
    //        obj.content = [NSString stringWithFormat:@"This is :%@",[NSNumber  numberWithLong: obj.ID]];
    //        [unSortedArray addObject:obj];
    //    }
    //
    //    [self sortNSComparator];
    //
    //    [self sortNSDescriptor];
    
    unSortedArray = [NSMutableArray new];
    for(NSInteger i = 0; i <10000;i++)
    {
        NSInteger idx = arc4random() % 10000;
        [unSortedArray addObject:[NSNumber numberWithInteger:idx]];
    }
    
    [self insertsort:unSortedArray];
    [self bubblesort:unSortedArray];
    [self selectorsort:unSortedArray];
    NSLog(@"快速排序开始");
    [self quickSort:unSortedArray leftIndex:0 rightIndex:unSortedArray.count - 1];
    NSLog(@"快速排序结束");
}

#pragma mark 四大排序方式

/**
 冒泡排序
 
 @param arr <#arr description#>
 */
- (void)bubblesort:(NSMutableArray *)arr
{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    for (int i = 0; i < arr.count; i++) {
        for (int j = 0; j < arr.count - i - 1;j++) {
            if ([arr[j+1]integerValue] < [arr[j] integerValue]) {
                int temp = [arr[j] intValue];
                arr[j] = arr[j + 1];
                arr[j + 1] = [NSNumber numberWithInt:temp];
            }
        }
    }
//    NSLog(@"冒泡排序后：%@",arr);
    CFAbsoluteTime end  = CFAbsoluteTimeGetCurrent();
    NSLog(@"冒泡排序: %0.3f ms", (end - start)*1000);
}

/**
 选择排序
 
 @param arr <#arr description#>
 */
- (void)selectorsort:(NSMutableArray *)arr
{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    for (int i = 0; i < arr.count; i ++) {
        for (int j = i + 1; j < arr.count; j ++) {
            if ([arr[i] integerValue] > [arr[j] integerValue]) {
                int temp = [arr[i] intValue];
                arr[i] = arr[j];
                arr[j] = [NSNumber numberWithInt:temp];
            }
        }
    }
    
//    NSLog(@"选择排序后：%@",arr);
    CFAbsoluteTime end  = CFAbsoluteTimeGetCurrent();
    NSLog(@"选择排序: %0.3f ms", (end - start)*1000);
}

/**
 快速排序
 
 @param arr   <#arr description#>
 @param left  <#left description#>
 @param right <#right description#>
 */
- (void)quickSort:(NSMutableArray *)arr leftIndex:(int)left rightIndex:(int)right
{
    if (left < right)
    {
        int temp = [self getMiddleIndex:arr leftIndex:left rightIndex:right];
        [self quickSort:arr leftIndex:left rightIndex:temp - 1];
        [self quickSort:arr leftIndex:temp + 1 rightIndex:right];
    }
}


/**
 @param arr <#arr description#>
 @param left <#left description#>
 @param right <#right description#>
 @return <#return value description#>
 */
- (int)getMiddleIndex:(NSMutableArray *)arr leftIndex:(int)left rightIndex:(int)right
{
    int tempValue = [arr[left] intValue];
    while (left < right) {
        while (left < right && tempValue <= [arr[right] intValue]) {
            right --;
        }
        if (left < right) {
            arr[left] = arr[right];
        }
        
        while (left < right && [arr[left] intValue] <= tempValue) {
            left ++;
        }
        if (left < right) {
            arr[right] = arr[left];
        }
    }
    arr[left] = [NSNumber numberWithInt:tempValue];
    return left;
}

/**
 插入排序
 
 @param arr <#arr description#>
 */
- (void)insertsort:(NSMutableArray *)arr
{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    for (int i = 1; i < arr.count; i ++) {
        int temp = [arr[i] intValue];
        
        for (int j = i - 1; j >= 0 && temp < [arr[j] integerValue]; j --) {
            arr[j + 1] = arr[j];
            arr[j] = [NSNumber numberWithInt:temp];
        }
    }
//    NSLog(@"插入排序后：%@",arr);
    CFAbsoluteTime end  = CFAbsoluteTimeGetCurrent();
    NSLog(@"插入排序: %0.3f ms", (end - start)*1000);
}

#pragma mark 系统自带的排序方式

-(void)sortNSComparator
{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    NSArray *sortedArray = [unSortedArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSInteger val1 = ((Obj*)obj1).ID;
        NSInteger val2 = ((Obj*)obj2).ID;
        //升序，假如需要降序的话，只需要修改下面的逻辑
        if (val1 < val2)
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }];
    CFAbsoluteTime end  = CFAbsoluteTimeGetCurrent();
    NSLog(@"time cost: %0.3f ms", (end - start)*1000);
    
}

-(void)sortNSDescriptor
{
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"ID" ascending:YES];
    //NSSortDescriptor *secondDescriptor = [[NSSortDescriptor alloc] initWithKey:@"content" ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObjects:firstDescriptor,nil];
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    NSArray  *sortedArray = [unSortedArray sortedArrayUsingDescriptors:sortArray];
    CFAbsoluteTime end  = CFAbsoluteTimeGetCurrent();
    NSLog(@"time 1cost: %0.3f ms", (end - start)*1000);
}

@end
