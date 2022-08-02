//
//  YHViewController.m
//  YHFloatContainerView
//
//  Created by chenyehong on 03/09/2022.
//  Copyright (c) 2022 chenyehong. All rights reserved.
//

#import "YHViewController.h"
#import "YHDemoItemView.h"
#import "YHFloatContainer.h"
#import "YHDemoHeader.h"

@interface YHViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YHFloatContainer *containerTags;
@property (nonatomic, strong) YHFloatContainer *containerCus;

@end

@implementation YHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    YHFloatContainer *containerTags = [YHFloatContainer new];
    containerTags.paddingInsets = UIEdgeInsetsMake(10, 10, 10, 2);
    containerTags.itemSpacing = 4;
    containerTags.lineSpacing = 4;
    containerTags.itemList = @[[self createAddBotton]];
    [containerTags updateUI:CGRectGetWidth(self.view.bounds)];
    _containerTags = containerTags;
    
    YHFloatContainer *containerCus = [YHFloatContainer new];
    containerCus.paddingInsets = UIEdgeInsetsMake(10, 10, 10, 2);
    containerCus.itemSpacing = 10;
    containerCus.lineSpacing = 10;
    containerCus.itemList = [self createCusViews];
    [containerCus updateUI:CGRectGetWidth(self.view.bounds)];
    _containerCus = containerCus;
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.estimatedRowHeight = 50;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[YHDemoHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([YHDemoHeader class])];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(64, 0, 10, 0));
    }];
    _tableView = tableView;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [tableView beginUpdates];
        [tableView endUpdates];
    });
}

// 添加标签
-(void)clickAddButton: (UIButton*)sender{
    YHFloatContainer *container = (YHFloatContainer*)sender.superview;
    NSMutableArray *itemList = container.itemList.mutableCopy;
    YHDemoItemView *itemView = [YHDemoItemView createWithLbTxt:[NSString stringWithFormat:@"标签%ld", itemList.count] btnTxt:@"✖️"];
    [itemView.btn addTarget:self action:@selector(clickDelButton:) forControlEvents:UIControlEventTouchUpInside];
    [itemList insertObject:itemView atIndex:itemList.count-1];
    container.itemList = itemList;
    [container updateUI:CGRectGetWidth(self.view.bounds)];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    });
}

// 删除标签
-(void)clickDelButton: (UIButton*)sender{
    YHDemoItemView *itemView = (YHDemoItemView *)sender.superview;
    YHFloatContainer *container = (YHFloatContainer*)itemView.superview;
    NSMutableArray *itemList = container.itemList.mutableCopy;
    [itemList removeObject:itemView];
    container.itemList = itemList;
    [container updateUI:CGRectGetWidth(self.view.bounds)];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    });
}

// Mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YHDemoHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([YHDemoHeader class])];
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (indexPath.row == 0) {
        [cell.contentView addSubview:_containerTags];
        [_containerTags mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    } else {
        [cell.contentView addSubview:_containerCus];
        [_containerCus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return cell;
}

// Mark - getter

-(UIButton*)createAddBotton{
    UIButton *btn = [UIButton new];
    [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    [btn setTitle:@" ➕ " forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor colorWithWhite:0.4 alpha:1].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 15;
    [btn addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(NSArray*)createCusViews{
    NSMutableArray *array = NSMutableArray.new;
    {
        UILabel *lb = UILabel.new;
        lb.text = @"这是Label控件";
        lb.backgroundColor = UIColor.redColor;
        [array addObject:lb];
    }
    {
        UISwitch *sw = [[UISwitch alloc] init];
        [array addObject:sw];
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"这是Button控件" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.greenColor;
        [array addObject:btn];
    }
    {
        UISwitch *sw = [[UISwitch alloc] init];
        sw.on = YES;
        [array addObject:sw];
    }
    {
        YHDemoItemView *itemView = [YHDemoItemView createWithLbTxt:@"自定义控件" btnTxt:@"😋"];
        [array addObject:itemView];
    }
    return array;
}

// Mark - other

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
