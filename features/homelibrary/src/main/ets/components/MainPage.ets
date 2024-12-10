import { router } from '@kit.ArkUI';
import { BreakPointConstants, EmptyView } from '@ohos/common'
import { findSwiperDataApi, findCatitemsDataApi } from '../api/ProcudtApi';
import { ActivityDataModel, SwipeDataModel, ProductDataModel } from '../viewModel/HomeModel'

interface  IMySwiper {
  swiperList: Array<SwipeDataModel>,
  currentBreakPoint: string
}
@Builder
function MySwiper($$: IMySwiper) {
  Swiper() {
    ForEach($$.swiperList, (item: SwipeDataModel) => {
      Image(item.image_src)
        .width('100%')
    }, (item: SwipeDataModel) => item.id.toString())
  }
  .indicator(true)
  .itemSpace(1)
  .width('100%')
  .autoPlay(true)
  .borderRadius(16)
  .height(150)
  .margin({ top: 20 })
  .displayCount($$.currentBreakPoint === BreakPointConstants.BREAKPOINT_XL ? 3 :
    [BreakPointConstants.BREAKPOINT_LG, BreakPointConstants.BREAKPOINT_MD].includes($$.currentBreakPoint) ? 2 : 1)
}


@Component
export struct MainPage {

  @StorageProp('currentBreakPoint') currentBreakPoint: string = 'sm'
  @State message: string = 'Hello World';
  @State swiperList: Array<SwipeDataModel> = []
  @State activityTitle: Array<ActivityDataModel> = []
  @State products: Array<ProductDataModel> = [
    {
    id: '12',
    add_time: '15166663280',
    cat_id: '3',
    cat_one_id: '2',
    cat_two_id: '1',
    cat_three_id: '1',
    goods_big_logo: '',
    goods_id: '57266',
    goods_name: '创维 65Mk 65英寸  4K超清数据',
    goods_number: '100',
    goods_price: '3435',
    goods_small_logo: '',
    goods_weight: '100',
    hot_number: '0',
    is_promote: false,
    upd_time: '15166663288',
  }, {
    id: '1122',
    add_time: '15166663280',
    cat_id: '3',
    cat_one_id: '2',
    cat_two_id: '1',
    cat_three_id: '1',
    goods_big_logo: '',
    goods_id: '57266',
    goods_name: '创维 65Mk 65英寸  4K超清数据 创维 65Mk 65英寸  4K超清数据 创维 65Mk 65英寸  4K超清数据 创维 65Mk 65英寸  4K超清数据',
    goods_number: '100',
    goods_price: '3435',
    goods_small_logo: '',
    goods_weight: '100',
    hot_number: '0',
    is_promote: false,
    upd_time: '15166663288',
  }, {
    id: '112122',
    add_time: '15166663280',
    cat_id: '3',
    cat_one_id: '2',
    cat_two_id: '1',
    cat_three_id: '1',
    goods_big_logo: '',
    goods_id: '57266',
    goods_name: '创维 65Mk 65英寸  4K超清数据',
    goods_number: '100',
    goods_price: '3435',
    goods_small_logo: '',
    goods_weight: '100',
    hot_number: '0',
    is_promote: false,
    upd_time: '15166663288',
  }, {
    id: '11221',
    add_time: '15166663280',
    cat_id: '3',
    cat_one_id: '2',
    cat_two_id: '1',
    cat_three_id: '1',
    goods_big_logo: '',
    goods_id: '57266',
    goods_name: '创维 65Mk 65英寸  4K超清数据',
    goods_number: '100',
    goods_price: '3435',
    goods_small_logo: '',
    goods_weight: '100',
    hot_number: '0',
    is_promote: false,
    upd_time: '15166663288',
  }]
  private  onChangeItem: (value: string) => void = (value: string) => {}
  fetchSwiperDataApi = async () => {
    const result = await findSwiperDataApi<Array<SwipeDataModel>, null>()
    this.swiperList = result.data
  }

  fetchActivity = async () => {
    const result = await findCatitemsDataApi<Array<ActivityDataModel>, null>()
    this.activityTitle = result.data
  }
  aboutToAppear(): void {
    this.fetchSwiperDataApi()
    this.fetchActivity()
  }
  @Builder
  Search() {
    Column() {
      Flex({
        justifyContent: FlexAlign.SpaceBetween
      }) {
        Image("https://p8.itc.cn/mpbp/pro/20210730/eeb28f5b34ea4b01bf683208cc42ae5f.jpeg").height('100%')
        Image($r("app.media.home_sao")).height('100%')
      }.height(24)
      .width('100%')
      .margin({
        bottom: 8
      })


      Row() {
        Image($r("app.media.search")).height(20).width(20).margin({ left: 12 })
      }
      .height(40)
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(20)
    }

  }

  @Builder
  MyNav() {
    Grid() {
      ForEach(this.activityTitle, (item: ActivityDataModel) => {
        GridItem() {
          Column() {
            Image(item.image_src).width(60).height(60)
            Text(item.name)
          }
          .justifyContent(FlexAlign.Center)

        }
      }, (item: ActivityDataModel) => item.id.toString())

    }
    .rowsTemplate('1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .width('100%')
    .height(180)
    .rowsGap(10)
    .columnsGap(10)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .margin({ top: 20, bottom: 10 })

  }

  @Builder
  ProductList() {
    if (this.products.length === 0) {
      EmptyView({
        defaultHeight: '30%'
      })
    } else {
      List({
        space: 10
      }) {
        ForEach(this.products, (item: ProductDataModel) => {
          ListItem() {
            Column() {
              Image(item.goods_big_logo ? item.goods_big_logo :
                'https://img0.baidu.com/it/u=2061919840,1457274808&fm=253&fmt=auto?w=500&h=500')
                .width('100%')
                .height(150)

              Column() {
                Text(item.goods_name)
                  .fontSize(16)
                  .height(70)
                  .maxLines(3)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Row() {
                  Text(`￥${item.goods_price}`)
                    .fontSize(18)
                    .fontColor(Color.Brown)
                    .width(60)

                  Image('https://img2.baidu.com/it/u=817595632,1376698477&fm=253&fmt=auto?w=500&h=500')
                    .width(30)
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .padding({
                left: 5,
                right: 5
              })

            }
            .width('96%')
            .height(260)
            .backgroundColor(Color.White)

          }.width('100%')
          .onClick(() => {
            this.onChangeItem(item.id)
            // router.pushNamedRoute({
            //   name: 'detail'
            // })
          })
        }, (item: ProductDataModel) => item.id)

      }
      .lanes(2)
    }
  }

  build() {
    Column() {

      Stack({
        alignContent: Alignment.Top
      }) {
        Image($r('app.media.home_bg'))
          .width('100%')
          .height(220)
          .objectFit(ImageFit.Auto)

        Flex({
          direction: FlexDirection.Column
        }) {
          //  搜索模块
          this.Search()
          Scroll() {
            Column() {
              // 轮播图
              MySwiper({
                swiperList: this.swiperList,
                currentBreakPoint: this.currentBreakPoint
              })

              // 楼诚
              this.MyNav()

              //商品列表
              this.ProductList()
            }
          }
        }.height('100%')
        .padding({
          left: 12,
          right: 12,
          top: 10
        })
      }

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f3f5')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
  }
}
