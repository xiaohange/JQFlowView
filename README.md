# JQFlowView
卡片式无限自动轮播图 ，无限/自动轮播，可自定义非当前显示view缩放和透明的特效等；喜欢❤️就star一下吧！

![](https://github.com/xiaohange/JQFlowView/blob/master/1.gif?raw=true) 
![](https://github.com/xiaohange/JQFlowView/blob/master/2.gif?raw=true)
![](https://github.com/xiaohange/JQFlowView/blob/master/3.gif?raw=true)
![](https://github.com/xiaohange/JQFlowView/blob/master/4.gif?raw=true)
## Instalation

Add the JQFlowView source files to your project.

## Usage

```objective-c
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
```
***JQFlowViewDelegate*** 代理方法：

```
- (CGSize)sizeForPageInFlowView:(JQFlowView *)flowView
{
    return CGSizeMake(KScreenWidth - 84, (KScreenWidth - 84) * 9 / 16);
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex
{
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}
```
***JQFlowViewDatasource*** 代理方法：

```
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
```

## Star
>iOS开发者交流群：446310206 喜欢就❤️❤️❤️star一下吧！你的支持是我更新的动力！ Love is every every every star! Your support is my renewed motivation!

## Other
[JQTumblrHud-高仿Tumblr App 加载指示器hud](https://github.com/xiaohange/JQTumblrHud)

[JQScrollNumberLabel：仿tumblr热度滚动数字条数](https://github.com/xiaohange/JQScrollNumberLabel)

[TumblrLikeAnimView-仿Tumblr点赞动画效果](https://github.com/xiaohange/TumblrLikeAnimView)

[JQMenuPopView-仿Tumblr弹出视图发音频、视频、图片、文字的视图](https://github.com/xiaohange/JQMenuPopView)

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).