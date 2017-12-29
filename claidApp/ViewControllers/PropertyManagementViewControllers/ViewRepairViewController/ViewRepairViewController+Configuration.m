//
//  ViewRepairViewController+Configuration.m
//  claidApp
//
//  Created by Zebei on 2017/12/22.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ViewRepairViewController+Configuration.h"
#import "ViewRepairViewController+LogicalFow.h"
#import "UIColor+Utility.h"
#import "UIScreen+Utility.h"

@implementation ViewRepairViewController (Configuration)

- (void)configureViews {
    [self viewRepairTableViewEdit];
    [self setupMenuViewEdit];
    [self initDSImageBrowseView];
}

- (void)setupMenuViewEdit {
    self.dataClassificationArray = @[@"全部",@"待处理",@"执行中",@"已拒绝",@"完成"];
    // trackerStyle:跟踪器的样式
    SPPageMenu  *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0 ,[UIScreen screenWidth], 40) trackerStyle:SPPageMenuTrackerStyleLine];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    pageMenu.selectedItemTitleColor =   [UIColor blackColor];
    pageMenu.unSelectedItemTitleColor = [UIColor colorFromHexCode:@"#999999"];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataClassificationArray selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.pageMenuView addSubview:pageMenu];
    [self.view bringSubviewToFront:pageMenu];
    self.pageMenu = pageMenu;

}
#pragma mrak- pageMenu DeleGate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    [self.viewRepairTableView.mj_header endRefreshing];
    [self.viewRepairTableView.mj_footer endRefreshing];
    if (fromIndex == toIndex && self.layouts.count > 0){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.pageMenu.selectedItemIndex == 0){
                self.layouts = self.layoutsOneArr;
            } else if (self.pageMenu.selectedItemIndex == 1) {
                self.layouts = self.layoutsTowArr;
            } else if (self.pageMenu.selectedItemIndex == 2) {
                self.layouts = self.layoutsThreeArr;
            } else if (self.pageMenu.selectedItemIndex == 3) {
                self.layouts = self.layoutsFourArr;
            } else {
                self.layouts = self.layoutsFiveArr;
            }
            [self.viewRepairTableView reloadData];
        });
        return;
    } else {
        if (self.pageMenu.selectedItemIndex == 0 && self.layoutsOneArr.count > 0){
            self.layouts = self.layoutsOneArr;
            [self.viewRepairTableView reloadData];
        } else if (self.pageMenu.selectedItemIndex == 1 && self.layoutsTowArr.count > 0) {
            self.layouts = self.layoutsTowArr;
            [self.viewRepairTableView reloadData];
        } else if (self.pageMenu.selectedItemIndex == 2 && self.layoutsThreeArr.count > 0) {
            self.layouts = self.layoutsThreeArr;
            [self.viewRepairTableView reloadData];
        } else if (self.pageMenu.selectedItemIndex == 3 && self.layoutsFourArr.count > 0) {
            self.layouts = self.layoutsFourArr;
            [self.viewRepairTableView reloadData];
        } else if (self.pageMenu.selectedItemIndex == 4 && self.layoutsFiveArr.count > 0){
            self.layouts = self.layoutsFiveArr;
            [self.viewRepairTableView reloadData];
        } else {
            self.mjBool =YES;
            [self.indicator startAnimating];
             switch (toIndex) {
                 case 0:
                     [self getDataPostpptRepairsByConditinorepairsPPTstatus:0 pageNum:1 pageSize:10];
                 break;
                case 1:
                     [self getDataPostpptRepairsByConditinorepairsPPTstatus:1 pageNum:1 pageSize:10];
                break;
                case 2:
                     [self getDataPostpptRepairsByConditinorepairsPPTstatus:2 pageNum:1 pageSize:10];
                break;
                case 3:
                     [self getDataPostpptRepairsByConditinorepairsPPTstatus:3 pageNum:1 pageSize:10];
                break;
                default:
                     [self getDataPostpptRepairsByConditinorepairsPPTstatus:5 pageNum:1 pageSize:10];
                break;
            }
        }
    }
    
   
    
}


- (void)viewRepairTableViewEdit {
    
    self.layouts = [NSMutableArray array];
    self.layoutsOneArr = [NSMutableArray array];
    self.layoutsTowArr = [NSMutableArray array];
    self.layoutsThreeArr = [NSMutableArray array];
    self.layoutsFourArr = [NSMutableArray array];
    self.layoutsFiveArr = [NSMutableArray array];
    self.dataNextPageArr = [NSMutableArray arrayWithObjects:@1,@1,@1,@1,@1, nil];
    self.dataPageArr = [NSMutableArray arrayWithObjects:@1,@1,@1,@1,@1, nil];
    [self.viewRepairTableView registerNib:[UINib nibWithNibName:@"ViewRepairTableViewCell" bundle:nil] forCellReuseIdentifier:VIEW_REPAIR_TABLEVIEW_CELL];
    self.viewRepairTableView.dataSource = self;
    self.viewRepairTableView.delegate = self;
    __weak typeof(self) weakSelf = self;
    self.viewRepairTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
        [weakSelf loadNewData];
    }];
    self.viewRepairTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求更多数据，请求成功之后，刷新列表
        [weakSelf loadNoreData];
    }];
   
}

#pragma mark- MJRefresh delegate
- (void)loadNewData {
     self.mjBool = YES;
    [self.indicator startAnimating];
    switch (self.pageMenu.selectedItemIndex) {
        case 0:
            [self getDataPostpptRepairsByConditinorepairsPPTstatus:0 pageNum:1 pageSize:10];
            break;
        case 1:
            [self getDataPostpptRepairsByConditinorepairsPPTstatus:1 pageNum:1 pageSize:10];
            break;
        case 2:
            [self getDataPostpptRepairsByConditinorepairsPPTstatus:2 pageNum:1 pageSize:10];
            break;
        case 3:
            [self getDataPostpptRepairsByConditinorepairsPPTstatus:3 pageNum:1 pageSize:10];
            break;
        default:
            [self getDataPostpptRepairsByConditinorepairsPPTstatus:5 pageNum:1 pageSize:10];
            break;
    }
}
- (void)loadNoreData{
    
    if ([self.dataNextPageArr[self.pageMenu.selectedItemIndex] integerValue] != 0){
        NSInteger nextNum = [self.dataPageArr[self.pageMenu.selectedItemIndex] integerValue];
        self.mjBool = NO;
        [self.indicator startAnimating];
        switch (self.pageMenu.selectedItemIndex) {
            case 0:
                [self getDataPostpptRepairsByConditinorepairsPPTstatus:0 pageNum:nextNum +1 pageSize:10];
                break;
            case 1:
                [self getDataPostpptRepairsByConditinorepairsPPTstatus:1 pageNum: nextNum+1 pageSize:10];
                break;
            case 2:
                [self getDataPostpptRepairsByConditinorepairsPPTstatus:2 pageNum:nextNum+1 pageSize:10];
                break;
            case 3:
                [self getDataPostpptRepairsByConditinorepairsPPTstatus:3 pageNum:nextNum+1 pageSize:10];
                break;
            default:
                [self getDataPostpptRepairsByConditinorepairsPPTstatus:5 pageNum:nextNum+1 pageSize:10];
                break;
        }
    } else {
        [self promptInformationActionWarningString:@"没有更过的数据了"];
        [self.viewRepairTableView.mj_footer endRefreshing];
    }
    

}
- (void)initDSImageBrowseView {
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.size = CGSizeMake(80, 80);
    self.indicator.center = CGPointMake([UIScreen screenWidth] / 2, [UIScreen screenHeight] / 2);
    self.indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
    self.indicator.clipsToBounds = YES;
    self.indicator.layer.cornerRadius = 6;
    [self.indicator startAnimating];
    [self.view addSubview:self.indicator];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((ViewRepairLayout *)self.layouts[indexPath.row]).cellHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}



- (void)present:(DSImageBrowseView *)imageView index:(NSInteger)index{
    UIView *fromView = nil;
    NSMutableArray *items = [NSMutableArray array];
    NSArray<DSImagesData *> *imagesData = imageView.layout.imagesData;
    
    for (NSUInteger i = 0,max = imagesData.count; i < max ;i++) {
        DSThumbnailView *imgView = imageView.imageViews[i];
        DSImagesData *imageData = imagesData[i];
        
        DSImageScrollItem * item = [[DSImageScrollItem alloc] init];
        item.thumbView = imgView;
        item.largeImageURL = imageData.largeImage.url;
        item.largeImageSize = CGSizeMake(imageData.largeImage.width, imageData.largeImage.height);
        [items addObject:item];
        if (i == index) {
            fromView = imgView;
        }
    }
    DSImageShowView *scrollView = [[DSImageShowView alloc] initWithItems:items type:DSImageShowTypeDefault];
    //    scrollView.blurEffectBackground = YES;
    [scrollView presentfromImageView:fromView toContainer:self.view index:index animated:YES completion:nil];
    scrollView.longPressBlock = ^(UIImageView *imageView) {
        // try to save original image data if the image contains multi-frame (such as GIF/APNG)
        id imageItem = [imageView.image yy_imageDataRepresentation];
        YYImageType type = YYImageDetectType((__bridge CFDataRef _Nonnull)(imageItem));
        if (type != YYImageTypePNG && type != YYImageTypeJPEG && type != YYImageTypeGIF) {
            imageItem = imageView;
        }
        //todo
    };
    
}


@end
