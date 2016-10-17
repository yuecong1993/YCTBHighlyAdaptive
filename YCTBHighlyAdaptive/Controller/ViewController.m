//
//  ViewController.m
//  cell自适应高度
//
//  Created by yishanmen on 16/7/26.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import "ViewController.h"
#import "YCModel.h"
#import "YCTableViewCell.h"
#import "ChartViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,strong) NSMutableArray *tableData;

@end

@implementation ViewController



-(NSMutableArray *)tableData{
    if (!_tableData) {
        _tableData = [[NSMutableArray alloc] init];
    }
    return _tableData;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self initTableView];
    [self createUserData];

}

//初始化tableView;
-(void)initTableView{
    CGRect frame = self.view.frame;
    _myTable = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    //代理类
    _myTable.delegate = self;
    //数据源
    _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTable.dataSource = self;
    [self.view addSubview:_myTable];
}

//测试数据
-(void)createUserData{
    
    
    NSArray *nameArray = @[@"鲁智深",@"武松",@"林冲",@"李逵",@"孙悟空",@"牛魔王",@"林黛玉",@"赵云"];
    NSArray *titleArray = @[@"花和尚拳鲁智深，本名鲁达，绰号“花和尚”，法名智深，中国著名古典小说《水浒传》中的经典人物形象之一。渭州（甘肃平凉）人，生活在北宋年间，原名鲁达，当过提辖，又称鲁提辖。身长八尺，长得面阔耳大、鼻直口方.",@"武松是施耐庵所作古典名著《水浒传》中的重要人物。因其排行在二，又叫“武二郎”。血溅鸳鸯楼后，为躲避官府抓捕，改作头陀打扮，江湖人称“行者武松”。武松曾经在景阳冈上空手打死一只吊睛白额虎，“武松打虎”的事迹在后世广为流传。武松最终在征方腊过程中被飞刀所伤，痛失左臂，最后在六和寺病逝，寿至八十",@"外号豹子头，是东京八十万禁军教头，妻子是张氏贞娘，岳父也是禁军教头，操刀鬼曹正是他的徒弟.",@"李逵是《水浒传》成书之前便已在文学作品中多次以主角身份出现的人物，但《水浒传》对其进行了很明显的加工塑造，使他成为一个心粗胆大、率直忠诚，同时又鲁莽好战的性格鲜明的角色",@"孙悟空是中国著名的神话角色之一，出自四大名著之《西游记》。祖籍东胜神州，由开天辟地以来的仙石孕育而生，因带领群猴进入水帘洞而成为众猴之王，尊为 “美猴王”。后历经千山万水拜须菩提祖师为师学艺，得名孙悟空，学会地煞七十二变[1]  、筋斗云、长生不老等高超的法术",@"千年牛妖，以吃人为生，首先出现在孙悟空自称齐天大圣之后，销声匿迹许久后主要出现在孙悟空与火焰山这一篇故事中，在书中一开始称他为大力王，又自号平天大圣（为七大圣之首）。他是翠云山和积雷山的主人，妻子是铁扇公主。",@"中国古典名著《红楼梦》的女主角，金陵十二钗之首，西方灵河岸绛珠仙草转世真身，荣府千金贾敏与巡盐御史林如海之女，贾母的外孙女，贾宝玉的姑表妹、恋人、知己，贾府通称林姑娘。[1]  她生得倾城倾国容貌，兼有旷世诗才，是世界文学作品中最富灵气的经典女性形象。",@"字子龙，常山真定（今河北省正定）人。身长八尺，姿颜雄伟，三国时期蜀汉名将。赵云跟随刘备将近三十年，先后参加过博望坡之战、长坂坡之战、江南平定战，独自指挥过入川之战、汉水之战、箕谷之战，都取得了非常好的战果。除了四处征战，赵云还先后以偏将军任桂阳太守，以留营司马留守公安，以翊军将军督江州。除此，赵云于平定益州时引霍去病故事劝谏刘备将田宅归还百姓，又于关羽张飞被害之后劝谏刘备不要伐吴，被后世赞为有大臣局量的儒将。于建兴七年寿终正寝。景耀四年（公元261年），刘禅下令追谥赵云，姜维与众臣商议后建议刘禅追谥赵云为顺平侯"];
    
    
    
    for (int i = 0; i<nameArray.count; i++) {
        
        YCModel *user = [[YCModel alloc] init];
        [user setUsername:nameArray[i]];
        [user setIntroduction:titleArray[i]];
        if (i<4) {
            [user setImagePath:[NSString stringWithFormat:@"%d",i+1]];
        }else{
            [user setImagePath:[NSString stringWithFormat:@"%d.jpg",i+1]];

        }
        
        [self.tableData addObject:user];
    }
    
    [_myTable reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"Cell";
    //自定义cell类
    YCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[YCTableViewCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    YCModel *user = [_tableData objectAtIndex:indexPath.row];
    cell.name.text = user.username;
    [cell.userImage setImage:[UIImage imageNamed:user.imagePath]];
    [cell setIntroductionText:user.introduction];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCTableViewCell *cell = [self tableView:_myTable cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",indexPath.row);
    ChartViewController *cvc = [[ChartViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
