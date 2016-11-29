//
//  CGAlbumPopView.m
//  CenturyGuard
//  相册顶部弹出的view
//  Created by duxiaoqiang on 16/7/11.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGAlbumPopView.h"

@interface CGAlbumPopView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end
@implementation CGAlbumPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        // 添加一个uibutton
        [self setupUI];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CGAlbumPopViewCell class]) bundle:nil] forCellReuseIdentifier:@"popViewCell"];
    }
    return self;
}

- (void)setupUI{
    UITableView * tableView =[[UITableView alloc] initWithFrame:self.frame];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight  = 40;
    tableView.backgroundColor = [UIColor clearColor];
    self.tableView = tableView;
    [self addSubview:tableView];
}

#pragma mark - UITabelViewDelegate代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGAlbumPopViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"popViewCell"];
    if (self.headImageUrl != nil && [self.messageList[indexPath.row] hasSuffix:@"信息未读"]) {
        //self.headImageUrl = [self.headImageUrl isKindOfClass:[NSString class]] ? self.headImageUrl : @"";
        [cell.iconIV sd_setImageWithURL:[NSURL URLWithString:self.headImageUrl] placeholderImage:[UIImage imageNamed:@"v3_contact_member"]];
         cell.descContent.text = self.messageList[indexPath.row];
         cell.iconIV.hidden = NO;
    }
    if ([self.messageList[indexPath.row] hasSuffix:@"您有照片上传失败"] ) {
         cell.descContent.text = self.messageList[indexPath.row];
         cell.lineLabel.hidden = YES;
         cell.iconIV.hidden = YES;
         cell.marginIconConst.constant = -20;
    }
    if (self.messageList.count == 1) {
        cell.lineLabel.hidden = YES;
    }
    cell.backgroundColor = [UIColor clearColor];
   
    __weak typeof(self) wakeSelf = self;
    [cell handleDelete:^(NSString* desc) {
        NSString * title = desc;
        if ([wakeSelf.messageList containsObject:title]) {
            [wakeSelf.messageList removeObject:title];
            [wakeSelf.tableView reloadData];
             wakeSelf.block();
        }
    }];
    [cell handleContentClick:^(NSString* desc) {
        BOOL isJumpUpload = NO;
        if ([wakeSelf.messageList[indexPath.row] hasSuffix:@"您有照片上传失败"]) { // 跳转相册未上传成功页面
            isJumpUpload = YES;
        }
        if (wakeSelf.jumpblock) {
            wakeSelf.jumpblock(isJumpUpload);
        }

    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)jumpBlock:(JumpClickBlock)block
{
    _jumpblock = block;
}
- (void)handleBlock:(deleteMsgBlock)block
{
    _block = block;
}

-(void)dealloc {
    NSLog(@" %@ dealloc ", NSStringFromClass([self class]));
}




@end
