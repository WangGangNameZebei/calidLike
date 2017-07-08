//
//  installViewControllerDataSource.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewControllerDataSource.h"
#import "MinFuncTionTableViewCell.h"
#import "ZBGroup.h"

@implementation installViewControllerDataSource

//这是tabview创建多少组的回调
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.installDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZBGroup *group = self.installDataArray[section];
    return group.isFolded? 0: group.size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   MinFuncTionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINN_FUNCTION_CELL_NIB];
    //将模型里的数据赋值给cell
    ZBGroup *group = self.installDataArray[indexPath.section];
    NSArray *arr=group.items;
    self.installCardData = arr[indexPath.row];
    cell.lanyaNameLabel.text = self.installCardData.installNamePractical;
  
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPress:)];
    [cell addGestureRecognizer:longPressGesture];

    return cell;
    
}
- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        if ([self.delegate respondsToSelector:@selector(installLongPress:)])
            [self.delegate installLongPress:recognizer];
    
    }
}


@end
