//
//  ViewController.m
//  JQFlowView
//
//  Created by 韩俊强 on 2017/5/5.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import "ViewController.h"
#import "JQIndexBannerSubview.h"
#import "JQFlowView.h"
#import <UIImageView+WebCache.h>

#define Width [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<JQFlowViewDelegate,JQFlowViewDataSource>
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

/**
 *  指示label
 */
@property (nonatomic, strong) UILabel *indicateLabel;

/**
 *  轮播图
 */
@property (nonatomic, strong) JQFlowView *pageFlowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageArray = [NSMutableArray arrayWithArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493976346622&di=bd99efa9257ef4ec836b479deb209169&imgtype=0&src=http%3A%2F%2Fimgwww.heiguang.net%2Fuploadfile%2F2015%2F0131%2F20150131043735168.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493976348429&di=a4aeb7f190d9dcdca229eacaba102811&imgtype=0&src=http%3A%2F%2Fwww.cnxeg.com%2Fpic%2F%25C7%25E9%25C8%25CB%25C7%25A3%25CA%25D6.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493976348428&di=20f6f270cd0ab905af994c05609523ff&imgtype=0&src=http%3A%2F%2Fs9.sinaimg.cn%2Forignal%2F4e04364bt74035a8f1808%26690",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493976348427&di=488ec44c6f36146f38214f81ef8a4918&imgtype=0&src=http%3A%2F%2Ftc.sinaimg.cn%2Fmaxwidth.2048%2Ftc.service.weibo.com%2Fp%2Fmmbiz_qpic_cn%2F9592a7a163f4d34a2caa94875fac38a2.jpg"]];
    [self setupUI];
}

- (void)setupUI {
    
    
    _pageFlowView = [[JQFlowView alloc] initWithFrame:CGRectMake(0, 0, Width, (Width - 84) * 9 / 16 + 24)];
    
    _pageFlowView.backgroundColor = [UIColor whiteColor];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 0.4;
    _pageFlowView.minimumPageScale = 0.85;
    _pageFlowView.orginPageCount = self.imageArray.count;
    _pageFlowView.isOpenAutoScroll = YES;
    _pageFlowView.autoTime = 3.0;
    _pageFlowView.orientation = JQFlowViewOrientationHorizontal;
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 24 - 8, Width, 8)];
    _pageFlowView.pageControl = pageControl;
    [_pageFlowView addSubview:pageControl];
    
    //    [self.view addSubview:pageFlowView];
    
    /*
     使用导航控制器(UINavigationController)如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件,请使用UIScrollView作为JQFlowView的容器View,才会显示正常,如下
    */
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, (Width - 84) * 9 / 16 + 24 + 65)];
    bottomScrollView.backgroundColor = [UIColor whiteColor];
    [_pageFlowView reloadData];
    [bottomScrollView addSubview:_pageFlowView];
    [self.view addSubview:bottomScrollView];
    
    [bottomScrollView addSubview:_pageFlowView];
    
    //添加到主view上
    [self.view addSubview:self.indicateLabel];
    
}

#pragma mark JQFlowView Delegate
- (CGSize)sizeForPageInFlowView:(JQFlowView *)flowView
{
    return CGSizeMake(Width - 84, (Width - 84) * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex
{
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)subIndex + 1];
}

#pragma mark JQFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(JQFlowView *)flowView
{
    return self.imageArray.count;
}

- (UIView *)flowView:(JQFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    JQIndexBannerSubview *bannerView = (JQIndexBannerSubview *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[JQIndexBannerSubview alloc] initWithFrame:CGRectMake(0, 0, Width - 84, (Width - 84) * 9 / 16)];
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
    self.indicateLabel.text = [NSString stringWithFormat:@"滚动到了第%ld页",pageNumber];
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UILabel *)indicateLabel
{
    if (_indicateLabel == nil) {
        _indicateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, Width, 16)];
        _indicateLabel.textColor = [UIColor blueColor];
        _indicateLabel.font = [UIFont systemFontOfSize:16.0];
        _indicateLabel.textAlignment = NSTextAlignmentCenter;
        _indicateLabel.text = @"label";
    }
    return _indicateLabel;
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


@end
