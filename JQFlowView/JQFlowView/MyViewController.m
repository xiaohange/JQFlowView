//
//  MyViewController.m
//  JQFlowView
//
//  Created by 韩俊强 on 2017/5/5.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import "MyViewController.h"
#import "JQIndexBannerSubview.h"
#import "JQFlowView.h"
#import <UIImageView+WebCache.h>

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,JQFlowViewDelegate,JQFlowViewDataSource>

@property (nonatomic, strong) UITableView *myTablView;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

/**
 *  轮播图
 */
@property (nonatomic, strong) JQFlowView *pageFlowView;

@property (nonatomic, strong) UIScrollView *scrollView; // 轮播图容器

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MyTableViewController";
    
    _imageArray = [NSMutableArray arrayWithArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493976346622&di=bd99efa9257ef4ec836b479deb209169&imgtype=0&src=http%3A%2F%2Fimgwww.heiguang.net%2Fuploadfile%2F2015%2F0131%2F20150131043735168.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493976348429&di=a4aeb7f190d9dcdca229eacaba102811&imgtype=0&src=http%3A%2F%2Fwww.cnxeg.com%2Fpic%2F%25C7%25E9%25C8%25CB%25C7%25A3%25CA%25D6.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493976348428&di=20f6f270cd0ab905af994c05609523ff&imgtype=0&src=http%3A%2F%2Fs9.sinaimg.cn%2Forignal%2F4e04364bt74035a8f1808%26690",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493976348427&di=488ec44c6f36146f38214f81ef8a4918&imgtype=0&src=http%3A%2F%2Ftc.sinaimg.cn%2Fmaxwidth.2048%2Ftc.service.weibo.com%2Fp%2Fmmbiz_qpic_cn%2F9592a7a163f4d34a2caa94875fac38a2.jpg"]];
    
    [self createMyTableView];
    
    [self setupUI]; // 轮播图
    
    [self.myTablView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myIdentify"];
    
    self.myTablView.tableHeaderView.backgroundColor = [UIColor redColor];
}

- (void)createMyTableView
{
    self.myTablView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.myTablView.delegate = self;
    self.myTablView.dataSource = self;
    [self.view addSubview:self.myTablView];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,-((KScreenWidth - 84) * 9 / 16 + 24), KScreenWidth, (KScreenWidth - 84) * 9 / 16 + 24)];
    
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    self.myTablView.contentInset = UIEdgeInsetsMake(((KScreenWidth - 84) * 9 / 16 + 24), 0, 0, 0);
    
    [self.myTablView addSubview:_scrollView];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myIdentify" forIndexPath:indexPath];
     cell.textLabel.text = @"这是一个轮播图在tableView中的测试";
    
     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark -- 下面是轮播图 --
- (void)setupUI {
    
    _pageFlowView = [[JQFlowView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, (KScreenWidth - 84) * 9 / 16 + 24)];
    
    _pageFlowView.backgroundColor = [UIColor whiteColor];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 0.4;
    _pageFlowView.minimumPageScale = 0.90;
    _pageFlowView.orginPageCount = self.imageArray.count;
    _pageFlowView.isOpenAutoScroll = YES;
    _pageFlowView.autoTime = 3.0;
    _pageFlowView.orientation = JQFlowViewOrientationHorizontal;
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 24 - 8, KScreenWidth, 8)];
    _pageFlowView.pageControl = pageControl;
    [_pageFlowView addSubview:pageControl];
    
    [_pageFlowView reloadData];
    [_scrollView addSubview:_pageFlowView];
    
}

#pragma mark JQFlowViewDelegate
- (CGSize)sizeForPageInFlowView:(JQFlowView *)flowView
{
    return CGSizeMake(KScreenWidth - 84, (KScreenWidth - 84) * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex
{
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

#pragma mark JQFlowViewDatasource
- (NSInteger)numberOfPagesInFlowView:(JQFlowView *)flowView
{
    return self.imageArray.count;
}

- (UIView *)flowView:(JQFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    JQIndexBannerSubview *bannerView = (JQIndexBannerSubview *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[JQIndexBannerSubview alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 84, (KScreenWidth - 84) * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
        //        bannerView.mainImageView.image = [bannerView.mainImageView.image stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    }
    
    //在这里下载网络图片
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]] placeholderImage:nil];
    
    //    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(JQFlowView *)flowView
{
    NSLog(@"滚动到了第%ld页",pageNumber);
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

#pragma mark --旋转屏幕改变JQFlowView大小之后实现该方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        [coordinator animateAlongsideTransition:^(id context) { [self.pageFlowView reloadData];
        } completion:NULL];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc
{
    [self.pageFlowView stopTimer];
}

 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
