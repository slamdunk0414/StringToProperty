# StringToProperty

通过服务器给的json字段 转化为swift可用的属性

例如将
                "user_id": 2,
                "type": "1",
                "type_invite_new": null,
                "money": "17.28",
                "buyer": 2,
                "order_id": 99,
                "create_time": "2020-06-12 15:23:00",
                "issue_time": null,
                "recovery_time": null,
                "is_withdrawal": "1",
                "status": "3",
                "nickname": "村里娃",
                "head_image":"https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIz7rUmS9KibXsK6b86gDp0aPNt39B8nPQMzZldkE8l9oJQLnlNuPMz91sicoTg5iaTB4icMgZOH4XQFA/132",
                "goods_name": "洋槐蜂蜜 | 天然蜜种 0添加",
                "norms": "450g",
                "amount": "17.28", // 订单总金额
               
     转化为
     
var user_id : Int?
var type : String!
var type_invite_new : Int?
var money : String!
var buyer : Int?
var order_id : Int?
var create_time : String!
var issue_time : Int?
var recovery_time : Int?
var is_withdrawal : String!
var status : String!
var nickname : String!
var head_image : String!
var goods_name : String!
var norms : String!
/// 订单总金额
var amount : String!
