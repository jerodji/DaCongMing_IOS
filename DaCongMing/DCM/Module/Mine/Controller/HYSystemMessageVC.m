//
//  HYSystemMessageVC.m
//  DaCongMing
//
//

#import "HYSystemMessageVC.h"
#import "HYSystemMessageCell.h"
#import "HYPayParterCostViewController.h"
#import "HYMineNetRequest.h"
#import "HYSystemMessageModel.h"
#import "HYParterPayResultVC.h"

@interface HYSystemMessageVC ()

@end

@implementation HYSystemMessageVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"系统消息";
    [self requestData];
}
//获取系统消息
- (void)requestData{
    
    [HYMineNetRequest getSystemInfoWithPageNo:1 ComplectionBlock:^(NSArray *datalist) {
        NSLog(@"获取系统消息成功");
        if (datalist) {
            
            [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary* dic = (NSDictionary*)obj;
                HYSystemMessageModel *model = [HYSystemMessageModel modelWithDictionary:dic];
                [self.datalist addObject:model];
                
            }];
            
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datalist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *systemMessageCellID = @"systemMessageCellID";
    HYSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:systemMessageCellID];
    if (!cell) {
        cell = [[HYSystemMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:systemMessageCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    HYSystemMessageModel* SystemMessage = self.datalist[indexPath.row];
    cell.model = SystemMessage;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 * WIDTH_MULTIPLE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HYSystemMessageModel* model = self.datalist[indexPath.row];
    if ([model.recomlevel isEqualToString:@"V4"]) {
        //实习合伙人
        [JJAlert showAlertTitle:@"您已成为实习合伙人" msg:@"是否到App Store下载\"聪明管理\"" cancleAction:^{
            if ([HYUserModel sharedInstance].token && model.id) {
                [self request_remindisread:[HYUserModel sharedInstance].token msgid:model.id];
            }
        } sureAction:^{
            if ([HYUserModel sharedInstance].token && model.id) {
                [self request_remindisread:[HYUserModel sharedInstance].token msgid:model.id];
            }
            
            NSString *urlCode = [@"聪明管理" stringByURLEncode];
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/%@/id1319732695?mt=8",urlCode];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        
    }
    else if([model.recomlevel isEqualToString:@"V2"]) {
        //实习经销商
        [JJAlert showAlertTitle:@"您已成为实习经销商" msg:@"是否到App Store下载\"聪明管理\"" cancleAction:^{
            if ([HYUserModel sharedInstance].token && model.id) {
                [self request_remindisread:[HYUserModel sharedInstance].token msgid:model.id];
            }
        } sureAction:^{
            if ([HYUserModel sharedInstance].token && model.id) {
                 [self request_remindisread:[HYUserModel sharedInstance].token msgid:model.id];
            }
            
            NSString *urlCode = [@"聪明管理" stringByURLEncode];
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/%@/id1319732695?mt=8",urlCode];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
    }
    else {
        HYPayParterCostViewController* PayParterCostViewController = [HYPayParterCostViewController new];
        PayParterCostViewController.dataSourceList = self.datalist;
        PayParterCostViewController.selectIndex = indexPath.row;
//        NSLog(@"选择了 %ld , %ld",(long)indexPath.row ,(long)PayParterCostViewController.selectIndex);
        [self.navigationController pushViewController:PayParterCostViewController animated:YES];
    }
}

//API_remindisread
- (void)request_remindisread:(NSString*)token msgid:(NSString*)msgid {
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_remindisread withParameter:@{@"token":token,@"id":msgid} isShowHUD:NO success:^(id returnData) {
        NSLog(@"%@",returnData)
    }];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
