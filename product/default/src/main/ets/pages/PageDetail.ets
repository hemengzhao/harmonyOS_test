import { router } from '@kit.ArkUI'
import { BreakPointSystem } from '@ohos/common';
import { findProductById } from '../api/ProductApi';
import { ProductDetailData } from '../viewmodel/Deatil';
import { ParamsType } from '../viewmodel/ParamsModel';

@Extend(Button)
function myTopBtn() {
  .backgroundColor(Color.Grey)
  .borderRadius('50%')
  .padding(10)
}

@Extend(Text)
function myFotBtn(bgColor: Color, borderRadius: BorderRadiuses) {
  .backgroundColor(bgColor)
  .fontColor(Color.White)
  .borderRadius(borderRadius)
  .fontSize(18)
  .height(40)
  .padding({
    left: 20,
    right: 20
  })
}

@Entry({
  routeName: 'detail'
})
@Component
struct PageDetail {
  @State message: string = 'Hello World';
  @State detail: ProductDetailData = {
    "id": "60e0895f65150080ab002c3e",
    "add_time": "1516663288",
    "cat_id": "9",
    "cat_one_id": "1",
    "cat_three_id": '9',
    "cat_two_id": '3',
    "goods_big_logo": "http://mage2,suning.cn/uimg/b2c/newcatentries/0070078057-000000000634917020_1_800x800.jpg",
    "goods_id": "57444",
    "goods_name": "创维(Skyworth) 42X6 2英寸10核智能酷开网络平板液品电视 (黑色)",
    "goods_number": '18',
    "goods_price": "1899",
    "goods_small_logo": [
      "https://img1.baidu.com/it/u=2134891183,2896015482&fm=253&fmt=auto&app=120&f=JPEG?w=868&h=800",
      "https://pic.rmb.bdstatic.com/bjh/news/6dee0d9510c5c7169b76cc53578baa9d5469.png",
      "https://img2.baidu.com/it/u=969583487,1936792146&fm=253&fmt=auto&app=120&f=JPEG?w=662&h=372",
      "https://imgservice.suning.cn/uimg1/b2c/image/0CbbYunGyuUirpcOWvLocw.jpg_800w_800h_4e"
    ],
    "goods_weight": "108",
    "hot_number": "0",
    "is_promote": "false",
    "upd_time": "1516663288",
    "evaluate": [
      {
        "userId": "1",
        "userIcon": "common/ic_person.png",
        "userNumber": "185****1937",
        "rating": 5,
        "desc": "和描述相符合，很喜欢，做工精致，颜色好看，原装正品。"
      },
      {
        "userId": "2",
        "userIcon": "common/ic_person.png",
        "userNumber": "185****1937",
        "rating": 5,
        "desc": "和描述相符合，很喜欢，做工精致，颜色好看，原装正品。"
      },
      {
        "userId": "3",
        "userIcon": "common/ic_person.png",
        "userNumber": "185****1937",
        "rating": 5,
        "desc": "和描述相符合，很喜欢，做工精致，颜色好看，原装正品。"
      }
    ]
  }
  @StorageProp('currentBreakPoint') currentBreakPoint: string = 'sm'
  private  breakPointSystem: BreakPointSystem = new BreakPointSystem()

  @State currIndex: number = 0
  aboutToAppear(): void {
    this.breakPointSystem.register()
    const params = router.getParams()
    const id = (params as ParamsType<string>).value
  }

  fetchDetailData = async (id: string) => {
    const res = await findProductById<string, string>(id)
  }

  @Styles boxCommonStyle(){
    .backgroundColor(Color.White)
    .borderRadius(16)
    .padding({
      left: 12,
      right: 12,
      bottom: 26,
      top:12
    })
    .width('100%')
    .margin({
      top: 12
    })
  }

  @Builder
  MySwiper() {
    Column(){
      Stack({
        alignContent: Alignment.BottomEnd
      }){
        Swiper() {
          ForEach(this.detail.goods_small_logo, (item: string) => {
            Image(item)
              .width('100%')
          }, (item: string) => item)
        }
        .indicator(true)
        .itemSpace(1)
        .width('100%')
        .autoPlay(true)
        .height('100%')
        .indicator(false)
        .onChange((val: number) => {
          this.currIndex = val
        })



        Text(`${this.currIndex} / ${this.detail.goods_small_logo.length}`)
          .fontSize(12)
          .fontColor(Color.White)
          .backgroundColor(Color.Grey)
          .borderRadius(9)
          .textAlign(TextAlign.Center)
          .width(35)
          .lineHeight(18)
          .margin({right: 16, bottom: 16})
      }
      .height(334)
      .width('100%')
    }
    .backgroundColor(Color.White)

  }

  @Builder
  MyTitleBar() {
      Flex({
        direction: FlexDirection.Column
      }){
        Text(`￥${this.detail.goods_price}`).fontSize(20).fontColor(Color.Brown)
        Text(this.detail.goods_number).fontSize(16).fontColor(Color.Black)
        Row(){

        }
      }
      .boxCommonStyle()
      .height(100)

  }

  @Builder ImageAndTextList(img: ResourceStr, title: string){
    Column({ space: 5 }) {
      Image(img).width(24)
      Text(title)
    }.justifyContent(FlexAlign.Center).height('100%').width('100%')
  }

  @Builder
  MyFooter() {

    GridRow({
      columns: {sm: 6, md: 10,lg: 12}
    }) {
      GridCol({
        span: { sm: 1, md: 3, lg: 3}
      }) {
        this.ImageAndTextList($r('app.media.tabbar_home'), '首页')

      }.height('100%')
      .width('100%')

      GridCol({
        span: { sm: 1, md: 3, lg: 3 }
      }) {
        this.ImageAndTextList($r('app.media.tabbar_car'), '购物车')
      }.height('100%')
      .width('100%')

      GridCol({
        span: { sm: 4, md: 4, lg: 6 }
      }) {
        Row() {
          Text('加入购物车').myFotBtn(Color.Orange, {
            topLeft: 20,
            topRight: 0,
            bottomLeft: 20,
            bottomRight: 0
          })

          Text('立即购买').myFotBtn(Color.Red, {
            topLeft: 0,
            topRight: 20,
            bottomLeft: 0,
            bottomRight: 20
          })
        }
        .height('100%')
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }.height('100%')
      .width('100%')
    }
    .height(this.currentBreakPoint === 'sm' ? 60 : this.currentBreakPoint === 'lg' ? 100 :70)

  }

  build() {
    Stack({
      alignContent: Alignment.Top
    }) {

      Flex({
        direction: FlexDirection.Column
      }) {
        Scroll() {

          GridRow({
            columns: {sm: 4, md: 8, lg: 12},
            gutter: 12
          }){
            GridCol({
              span: {sm: 4, md: 8, lg: 5},
            }){
              this.MySwiper()
            }

            GridCol({
              span: {sm: 4, md: 8, lg: 7},
            }){
              this.MyTitleBar()
            }

            GridCol({
              span: {sm: 4, md: 8, lg: 7},
            }){
              Column(){
                Text('商品数据')
              }.boxCommonStyle()

            }

          }
        }.flexGrow(1)
        .backgroundColor('red')

        // 底部按钮
        GridRow({
          columns: {sm: 4, md: 8, lg: 12},
          gutter: 12
        }){
          GridCol({
            span: {sm: 4, md: 6, lg: 6},
            offset: {md: 1, lg: 3}
          }){
            this.MyFooter()
          }
        }

      }

      // 顶部后退
      Row() {
        Button() {
          Image($r('app.media.goBack')).width(20).height(20)
        }.myTopBtn()

        Button() {
          Image($r('app.media.share')).width(20).height(20)
        }.myTopBtn()

      }.justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left: 10,
        right: 10,
        top: 10
      })
      .width('100%')

    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f1f3f5')
  }
}