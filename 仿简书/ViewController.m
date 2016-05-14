//
//  ViewController.m
//  仿简书
//
//  Created by 徐茂怀 on 16/5/5.
//  Copyright © 2016年 徐茂怀. All rights reserved.
//

#import "ViewController.h"
#import "UIView+UIView_Add.h"
#define SCREEN_HEIGHT     ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH      ([[UIScreen mainScreen] bounds].size.width)
@interface ViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *userImg;
@property (strong, nonatomic) IBOutlet UITableView *wenjiTableView;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBtn;
@property (strong, nonatomic) IBOutlet UIView *selectView;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIButton *dongtaiBtn;
@property (strong, nonatomic) IBOutlet UIButton *wenzhangBtn;
@property (strong, nonatomic) IBOutlet UIView *huakuaiView;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;
@property (strong, nonatomic) IBOutlet UIView *moreView;
@property (strong, nonatomic) IBOutlet UIScrollView *subScroll;
@property (strong, nonatomic) IBOutlet UITableView *dongtaiTableView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //头像和编辑按钮的的设置
    _userImg.layer.masksToBounds = YES;
    _userImg.layer.cornerRadius = 30;
    _navBar.barTintColor = [UIColor whiteColor];
    _navBar.clipsToBounds = NO;
    _bianjiBtn.layer.masksToBounds = YES;
    _bianjiBtn.layer.borderColor = [UIColor colorWithRed:0.53 green:0.91 blue:0.56 alpha:1].CGColor;
    _bianjiBtn.layer.borderWidth = 1;
    _bianjiBtn.layer.cornerRadius = 3;
    //在小的scrollerview里面添加2个tableview和一个view
    _subScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    _moreView.x = SCREEN_WIDTH * 2;
    _moreView.width = SCREEN_WIDTH;
    [_subScroll addSubview:_moreView];
    _wenjiTableView.x = SCREEN_WIDTH ;
    [_subScroll addSubview:_wenjiTableView];
    _dongtaiTableView.x = 0;
    [_subScroll addSubview:_dongtaiTableView];
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //当整体滑动到一个临界值时将tableview设为可滑动或者不可活动
    if (_scrollview.contentOffset.y / 3 <= 53.00 && _wenjiTableView.contentOffset.y <= 0.1) {
        [_wenjiTableView setScrollEnabled:NO];
    }
    if (_scrollview.contentOffset.y / 3 <= 53.00 && _dongtaiTableView.contentOffset.y <= 0.1) {
        [_dongtaiTableView setScrollEnabled:NO];
    }
    //左右滑动小的scrollerview让文字颜色改变和小滑块滑动
    if (scrollView == _subScroll) {
        CGFloat i = _subScroll.contentOffset.x / SCREEN_WIDTH;
        if (i == 0) {
            _dongtaiBtn.selected = YES;
            _wenzhangBtn.selected = NO;
            _moreBtn.selected = NO;
            [UIView animateWithDuration:0.5 animations:^{
                _huakuaiView.centerX = _dongtaiBtn.centerX;
            }];
        }else if ( i == 1){
            _wenzhangBtn.selected = YES;
            _dongtaiBtn.selected = NO;
            _moreBtn.selected = NO;
            [UIView animateWithDuration:0.5 animations:^{
                _huakuaiView.centerX = _wenzhangBtn.centerX;
            }];
            [UIView animateWithDuration:0.5 animations:^{
                _subScroll.contentOffset = CGPointMake(SCREEN_WIDTH , 0);
            }];
        }else if (i == 2){
            _moreBtn.selected = YES;
            _dongtaiBtn.selected = NO;
            _wenzhangBtn.selected = NO;
            [UIView animateWithDuration:0.5 animations:^{
                _huakuaiView.centerX = _moreBtn.centerX;
            }];
            [UIView animateWithDuration:0.5 animations:^{
                _subScroll.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
            }];
        }
        return;
    }
    if (scrollView == _scrollview) {
        CGFloat contentY = _scrollview.contentOffset.y / 3;
        if (contentY <= 25 && contentY >= 0) {
            //改变头像的大小
            [_userImg setHeight:60 - contentY];
            _userImg.centerX = self.view.centerX;
            [_userImg setWidth:60 - contentY];
            _userImg.layer.cornerRadius = _userImg.width/2;
        }
        if (contentY >= 53) {
            //让scrollerview停留之
            _scrollview.contentOffset = CGPointMake(0, 53 * 3);
            [_wenjiTableView setScrollEnabled:YES];
            [_dongtaiTableView setScrollEnabled:YES];
        }
    }
}
//点击按钮的动作

- (IBAction)dongtaiAction:(UIButton *)sender {
    sender.selected = YES;
    _wenzhangBtn.selected = NO;
    _moreBtn.selected = NO;
    [UIView animateWithDuration:0.5 animations:^{
         _huakuaiView.centerX = sender.centerX;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _subScroll.contentOffset = CGPointMake(0, 0);
        _scrollview.contentOffset = CGPointMake(0, 159);
    }];
    [self changeImage];
    
}

- (IBAction)wenzhangAction:(UIButton *)sender {
    sender.selected = YES;
    _dongtaiBtn.selected = NO;
    _moreBtn.selected = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _huakuaiView.centerX = sender.centerX;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _subScroll.contentOffset = CGPointMake(SCREEN_WIDTH , 0);
         _scrollview.contentOffset = CGPointMake(0, 159);
    }];
    [self changeImage];
}
- (IBAction)moreAction:(UIButton *)sender {
    sender.selected = YES;
    _dongtaiBtn.selected = NO;
    _wenzhangBtn.selected = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _huakuaiView.centerX = sender.centerX;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _subScroll.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
         _scrollview.contentOffset = CGPointMake(0, 159);
    }];
    [self changeImage];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_dongtaiTableView]) {
        return 100;
    }
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_dongtaiTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dongtaicell" forIndexPath:indexPath];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wenzhangcell" forIndexPath:indexPath];
    return cell;
}

-(void)changeImage
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _userImg.frame;
        frame.size.height = 36.57;
        frame.size.width = 35.5;
        _userImg.frame = frame;
        _userImg.layer.cornerRadius = _userImg.width / 2;
        _userImg.centerX = self.view.centerX;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
