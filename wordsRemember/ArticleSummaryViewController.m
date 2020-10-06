//
//  ArticleSummaryViewController.m
//  wordsRemember
//
//  Created by liuhongnian on 2020/10/2.
//  Copyright © 2020 liuhongnian. All rights reserved.
//

#import "ArticleSummaryViewController.h"
#import "wordsRemember-Swift.h"
#import "ArticleDetailsViewController.h"

#import "NSDate+AixCategory.h"

#import "NSObject+FBKVOController.h"
#import "Masonry.h"
#import "YYLabel.h"

@interface ArticleSummaryViewController ()

@property (nonatomic, strong) UILabel *day;
@property (nonatomic, strong) UILabel *week;

@property (nonatomic, strong) YYLabel *todayTag;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) YYLabel *articleContent;
@property (nonatomic, strong) UIButton *refreshBtn;

@property (nonatomic, strong) ArticleViewModel *viewModel;

@end

@implementation ArticleSummaryViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil
                               bundle:nibBundleOrNil]) {
        
        _viewModel = [[ArticleViewModel alloc] init];
        [self observeViewModel];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadTheUI];
    [self p_addMasonry];
    
    //request
    [_viewModel todayArticle];
    
    NSInteger dayNum = [NSDate date].x_day;
    _day.text = [NSString stringWithFormat:@"%02ld",dayNum];
    
    NSArray *weeksArr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSInteger weekNum = [NSDate date].x_weekDay;
    _week.text = [NSString stringWithFormat:@"%@", weeksArr[weekNum -1]];
}


- (void)loadTheUI
{
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];

    [self.view addSubview:self.day];
    [self.view addSubview:self.week];
    
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.todayTag];
    
    __weak typeof(self) weakSelf = self;
    self.articleContent.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSDictionary *article = weakSelf.viewModel.article;
        ArticleDetailsViewController *vc = [[ArticleDetailsViewController alloc] init];
        vc.article = article;
        [weakSelf.navigationController pushViewController:vc
                                                 animated:YES];
    };
    [self.containerView addSubview:self.articleContent];
    
    [self.containerView addSubview:self.refreshBtn];
    
}

#pragma mark UI actions

- (void)refreshAction
{
    [_viewModel todayArticle];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - # Private Methods

- (void)observeViewModel
{
    
    __weak typeof(self) weakSelf = self;
    
    [self.KVOController observe:self.viewModel
                        keyPath:FBKVOKeyPath(_viewModel.article)
                        options:NSKeyValueObservingOptionNew
                          block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *resultDic = change[NSKeyValueChangeNewKey];
            
            NSString *title = resultDic[@"title"];
            NSString *content = resultDic[@"article"];

            weakSelf.todayTag.text = title;
            weakSelf.articleContent.text = content;
            
            weakSelf.todayTag.hidden = NO;
            weakSelf.articleContent.hidden = NO;
            
            weakSelf.refreshBtn.hidden = YES;
            
        });
    }];
    
    [self.KVOController observe:self.viewModel
                        keyPath:FBKVOKeyPath(_viewModel.error)
                        options:NSKeyValueObservingOptionNew
                          block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        
        NSError *error = change[NSKeyValueChangeNewKey];
        if (error.domain) {
            NSLog(@"失败:%@",error.domain);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.todayTag.hidden = YES;
            weakSelf.articleContent.hidden = YES;
            
            weakSelf.refreshBtn.hidden = NO;

        });
    }];

}

- (void)p_addMasonry {
    
    [self.day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(84);
        make.left.equalTo(self.view.mas_left).offset(44);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];

    [self.week mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.day.mas_right).offset(0);
        make.bottom.equalTo(self.day.mas_bottom).offset(-13);
        make.height.mas_equalTo(20);
    }];
    

    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.day.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(44);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.right.equalTo(self.view.mas_right).offset(-44);
        
    }];
    
    [self.todayTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.mas_top).offset(40);
        make.right.equalTo(self.containerView.mas_right).offset(-20);
        make.width.mas_equalTo(100);
        make.height.equalTo(self.containerView.mas_height).multipliedBy(0.3);
    }];
    
    [self.articleContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.todayTag.mas_bottom).offset(60);
        make.left.equalTo(self.containerView.mas_left).offset(20);
        make.bottom.equalTo(self.containerView.mas_bottom).offset(-20);
        make.right.equalTo(self.containerView.mas_right).offset(-20);
    }];
    
    
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.containerView.mas_centerX);
        make.centerY.equalTo(self.containerView.mas_centerY);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        
    }];



}

#pragma mark - # Getter

- (UILabel *)day {
    if (!_day) {
        _day = [[UILabel alloc] initWithFrame:CGRectZero];
        _day.font = [UIFont systemFontOfSize:46];
    }
    return _day;
}

- (UILabel *)week {
    if (!_week) {
        _week = [[UILabel alloc] initWithFrame:CGRectZero];
        _week.font = [UIFont systemFontOfSize:16];
        _week.textColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1.00];
    }
    return _week;
}

- (YYLabel *)articleContent {
    if (!_articleContent) {
        
        _articleContent = [[YYLabel alloc] initWithFrame:CGRectZero];
        _articleContent.numberOfLines = 0;
        _articleContent.font = [UIFont fontWithName:@"Times New Roman" size:20];
        _articleContent.textVerticalAlignment = YYTextVerticalAlignmentTop;
    }
    return _articleContent;
}

- (YYLabel *)todayTag {
    if (!_todayTag) {
        
        _todayTag = [[YYLabel alloc] initWithFrame:CGRectZero];
        _todayTag.font = [UIFont systemFontOfSize:30];
        _todayTag.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _todayTag.verticalForm = YES;

    }
    return _todayTag;
}

- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.whiteColor;
        _containerView.layer.cornerRadius = 10;
        _containerView.layer.shadowColor = [UIColor blackColor].CGColor;
        
        //    阴影的透明度
        _containerView.layer.shadowOpacity = 0.1f;
        //    阴影的圆角
        //    _containerView.layer.shadowRadius = 5.f;
        //    阴影偏移量
        _containerView.layer.shadowOffset = CGSizeMake(0.1,0.1);
        }
    
    return _containerView;
    
}

- (UIButton *)refreshBtn
{
    if (!_refreshBtn) {
        _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refreshBtn setImage:[[UIImage imageNamed:@"refresh_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                     forState:UIControlStateNormal];
        [_refreshBtn addTarget:self
                        action:@selector(refreshAction)
              forControlEvents:UIControlEventTouchUpInside];
        
        _refreshBtn.hidden = YES;
    }
    
    return _refreshBtn;
    
}

@end
