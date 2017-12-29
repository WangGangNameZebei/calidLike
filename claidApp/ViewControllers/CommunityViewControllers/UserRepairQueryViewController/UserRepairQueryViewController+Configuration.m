//
//  UserRepairQueryViewController+Configuration.m
//  claidApp
//
//  Created by Zebei on 2017/12/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "UserRepairQueryViewController+Configuration.h"
#import "UserRepairQueryViewController+LogicalFlow.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"

@implementation UserRepairQueryViewController (Configuration)
- (void)configureViews {
   
    [self userRepairQueryTableViewEdit];
    [self initDSImageBrowseView];
    [self setupMenuViewEdit];
}

- (void)setupMenuViewEdit {
    self.datapageMenuArray = @[@"全部",@"已提交",@"已撤回",@"被拒绝"];
    // trackerStyle:跟踪器的样式
    SPPageMenu  *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0 ,[UIScreen screenWidth], 40) trackerStyle:SPPageMenuTrackerStyleLine];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    pageMenu.selectedItemTitleColor =   [UIColor blackColor];
    pageMenu.unSelectedItemTitleColor = [UIColor colorFromHexCode:@"#999999"];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.datapageMenuArray selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.pageMenuView addSubview:pageMenu];
    [self.view bringSubviewToFront:pageMenu];
    self.userpageMenu = pageMenu;
    
}
#pragma mrak- pageMenu DeleGate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    [self.userRepairQueryTableView.mj_header endRefreshing];
    [self.userRepairQueryTableView.mj_footer endRefreshing];
    if (fromIndex == toIndex && self.layouts.count > 0){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.userpageMenu.selectedItemIndex == 0){
                self.layouts = self.layoutsOneArr;
            } else if (self.userpageMenu.selectedItemIndex == 1) {
                self.layouts = self.layoutsTowArr;
            } else if (self.userpageMenu.selectedItemIndex == 2) {
                self.layouts = self.layoutsThreeArr;
            } else  {
                self.layouts = self.layoutsFourArr;
            }
            [self.userRepairQueryTableView reloadData];
        });
        return;
    } else {
        if (toIndex == 0 && self.layoutsOneArr.count > 0){
            self.layouts = self.layoutsOneArr;
            [self.userRepairQueryTableView reloadData];
        } else if (toIndex == 1 && self.layoutsTowArr.count > 0) {
            self.layouts = self.layoutsTowArr;
            [self.userRepairQueryTableView reloadData];
        } else if (toIndex == 2 && self.layoutsThreeArr.count > 0) {
            self.layouts = self.layoutsThreeArr;
            [self.userRepairQueryTableView reloadData];
        } else if (toIndex == 3 && self.layoutsFourArr.count > 0) {
            self.layouts = self.layoutsFourArr;
            [self.userRepairQueryTableView reloadData];
        }  else {
            self.mjBool =YES;
            [self.indicator startAnimating];
            switch (toIndex) {
                case 0:
                    [self setuserRepairQueryPostDataStatus:0 pageNum:1];
                    break;
                case 1:
                    [self setuserRepairQueryPostDataStatus:1 pageNum:1];
                    break;
                case 2:
                    [self setuserRepairQueryPostDataStatus:2 pageNum:1];
                    break;
                default:
                    [self setuserRepairQueryPostDataStatus:3 pageNum:1];
                    break;
            }
        }
    }
    
}

- (void)userRepairQueryTableViewEdit {
    
    self.layouts = [NSMutableArray array];
    self.layoutsOneArr = [NSMutableArray array];
    self.layoutsTowArr = [NSMutableArray array];
    self.layoutsThreeArr = [NSMutableArray array];
    self.layoutsFourArr = [NSMutableArray array];
    self.dataNextPageArr = [NSMutableArray arrayWithObjects:@1,@1,@1,@1, nil];
    self.dataPageArr = [NSMutableArray arrayWithObjects:@1,@1,@1,@1, nil];
    [self.userRepairQueryTableView registerNib:[UINib nibWithNibName:@"UserRepairTableViewCell" bundle:nil] forCellReuseIdentifier:USER_REPAIR_TABLEVIEW_CELL];
    self.userRepairQueryTableView.dataSource = self;
    self.userRepairQueryTableView.delegate = self;
    __weak typeof(self) weakSelf = self;
    self.userRepairQueryTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
        [weakSelf loadNewData];
    }];
    self.userRepairQueryTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求更多数据，请求成功之后，刷新列表
        [weakSelf loadNoreData];
    }];
    
}
- (void)loadNewData {
    self.mjBool = YES;
    [self.indicator startAnimating];
    switch (self.userpageMenu.selectedItemIndex) {
        case 0:
            [self setuserRepairQueryPostDataStatus:0 pageNum:1];
            break;
        case 1:
            [self setuserRepairQueryPostDataStatus:1 pageNum:1];
            break;
        case 2:
            [self setuserRepairQueryPostDataStatus:2 pageNum:1];
            break;
        default:
            [self setuserRepairQueryPostDataStatus:3 pageNum:1];
            break;
    }
    
}
- (void)loadNoreData {
    if ([self.dataNextPageArr[self.userpageMenu.selectedItemIndex] integerValue] != 0){
        NSInteger nextNum = [self.dataPageArr[self.userpageMenu.selectedItemIndex] integerValue];
        self.mjBool = NO;
        [self.indicator startAnimating];
        switch (self.userpageMenu.selectedItemIndex) {
            case 0:
                [self setuserRepairQueryPostDataStatus:0 pageNum:nextNum+1];
                break;
            case 1:
                [self setuserRepairQueryPostDataStatus:1 pageNum:nextNum+1];
                break;
            case 2:
                [self setuserRepairQueryPostDataStatus:2 pageNum:nextNum+1];
                break;
            default:
                [self setuserRepairQueryPostDataStatus:3 pageNum:nextNum+1];
                break;
        }
    } else {
        [self promptInformationActionWarningString:@"没有更过的数据了"];
        [self.userRepairQueryTableView.mj_footer endRefreshing];
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
    return ((UserRepairQueryLayout *)self.layouts[indexPath.row]).cellHeight;
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
