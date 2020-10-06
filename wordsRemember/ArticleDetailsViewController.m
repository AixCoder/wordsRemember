//
//  ArticleDetailsViewController.m
//  wordsRemember
//
//  Created by liuhongnian on 2020/10/6.
//  Copyright © 2020 liuhongnian. All rights reserved.
//

#import "ArticleDetailsViewController.h"

#import "YYTextView.h"
#import "NSAttributedString+YYText.h"
#import "Masonry.h"

@interface ArticleDetailsViewController ()

@property (nonatomic, strong)UIView *titleView;
@property (nonatomic, strong) UILabel *articleTitle;
@property (nonatomic, strong) UILabel *author;

@property (nonatomic, strong) YYTextView *articleView;

@end

@implementation ArticleDetailsViewController

//- (void)injected
//{
//    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj removeFromSuperview];
//    }];
//
//    [self loadTheUI];
//    [self addConstraints];
//
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSAssert(_article, @"");
    
    [self loadTheUI];
    [self addConstraints];
    
    
    NSString *title = _article[@"provenance"];
    _articleTitle.text = title;
    _author.text = _article[@"author"][@"name"];
    
    
    {
        
        NSString *articleString = _article[@"article"];
        articleString = (articleString.length == 0) ? @"" : articleString;
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:articleString];
        
        attString.yy_font = [UIFont fontWithName:@"Times New Roman" size:22];
        attString.yy_lineSpacing = 5;
        attString.yy_firstLineHeadIndent = 20;
        _articleView.attributedText = attString;
    }

}

- (void)loadTheUI
{

    [self.titleView addSubview:self.articleTitle];
    [self.titleView addSubview:self.author];
    self.navigationItem.titleView = self.titleView;
    
    [self.view addSubview:self.articleView];
    
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[[UIImage imageNamed:@"backItem"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [back addTarget:self action:@selector(closeDetailsView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)closeDetailsView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addConstraints
{
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(44);
    }];
    
    [_articleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_top);
        make.left.equalTo(self.titleView.mas_left);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.titleView.mas_right);
    }];
    
    [_author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.articleTitle.mas_bottom);
        make.left.equalTo(self.titleView.mas_left);
        make.bottom.equalTo(self.titleView.mas_bottom);
        make.right.equalTo(self.titleView.mas_right);
    }];
    
    
    [_articleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark getter

- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = UIView.new;
    }
    return _titleView;
}

- (UILabel *)articleTitle
{
    if (!_articleTitle) {
        _articleTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _articleTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _articleTitle;
}

- (UILabel *)author
{
    if (!_author) {
        _author = [[UILabel alloc] initWithFrame:CGRectZero];
        _author.textAlignment = NSTextAlignmentCenter;
    }
    return _author;
}

- (YYTextView *)articleView
{
    if (!_articleView) {
        _articleView = [[YYTextView alloc] initWithFrame:CGRectZero];
        _articleView.editable = NO;
        _articleView.textContainerInset = UIEdgeInsetsMake(20, 20, 10, 20);
        _articleView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    }
    return _articleView;
}

@end
