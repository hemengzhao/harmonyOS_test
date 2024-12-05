import { BreakPointConstants, EmptyView } from '@ohos/common'
import { ActivityDataModel, SwipeDataModel, ProductDataModel  } from '../viewModel/HomeModel'

@Builder
function MySwiper(array: Array<SwipeDataModel>, currentBreakPoint: string) {
  Swiper() {
    ForEach(array, (item: SwipeDataModel) => {
      Image(item.image_src)
        .width('100%')
    }, (item: SwipeDataModel) => item.id)
  }
  .indicator(true)
  .itemSpace(1)
  .width('100%')
  .autoPlay(true)
  .borderRadius(16)
  .height(150)
  .margin({ top: 20  })
  .displayCount(currentBreakPoint === BreakPointConstants.BREAKPOINT_XL ? 3 :
    [BreakPointConstants.BREAKPOINT_LG, BreakPointConstants.BREAKPOINT_MD].includes(currentBreakPoint) ? 2 : 1)
}


@Component
export struct MainPage {
  @StorageProp('currentBreakPoint') currentBreakPoint: string = 'sm'
  @State message: string = 'Hello World';
  @State swiperList: Array<SwipeDataModel> = [

    {
      id: '112',
      goods_id: 12,
      image_src: 'https://img1.baidu.com/it/u=3075258978,381454706&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800',
      navigator_url: '/page/ca',
      open_type: 'navigate'
    },

    {
      id: '121',
      goods_id: 12,
      image_src: 'https://iknow-pic.cdn.bcebos.com/78310a55b319ebc4fdc8e3079026cffc1f1716ff',
      navigator_url: '/page/ca',
      open_type: 'navigate'
    },

    {
      id: '1212',
      goods_id: 12,
      image_src: 'https://iknow-pic.cdn.bcebos.com/730e0cf3d7ca7bcba60a76b1ac096b63f624a83f',
      navigator_url: '/page/ca',
      open_type: 'navigate'
    },

    {
      id: '132',
      goods_id: 12,
      image_src: 'https://img-baofun.zhhainiao.com/fs/e590f94250ceecc3c4b197fa40b9db3c.jpg',
      navigator_url: '/page/ca',
      open_type: 'navigate'
    }

  ]
  @State activityTitle: Array<ActivityDataModel> = [
    {
      id: '12',
      name: '旅行日记',
      image_src: 'https://pic.baike.soso.com/ugc/baikepic2/33215/20171118145305-519083113_png_4779_3467_317321.jpg/0',
      navigator_url: '/page/ca',
      open_type: 'switchTab'
    },
    {
      id: '121',
      name: '旅行日记',
      image_src: 'https://pic.baike.soso.com/ugc/baikepic2/33215/20171118145305-519083113_png_4779_3467_317321.jpg/0',
      navigator_url: '/page/ca',
      open_type: 'switchTab'
    },
    {
      id: '1212',
      name: '旅行日记',
      image_src: 'https://pic.baike.soso.com/ugc/baikepic2/33215/20171118145305-519083113_png_4779_3467_317321.jpg/0',
      navigator_url: '/page/ca',
      open_type: 'switchTab'
    },
    {
      id: '1223',
      name: '旅行日记',
      image_src: 'https://pic.baike.soso.com/ugc/baikepic2/33215/20171118145305-519083113_png_4779_3467_317321.jpg/0',
      navigator_url: '/page/ca',
      open_type: 'switchTab'
    }
  ]
  @State products: Array<ProductDataModel> = [{
    id: '12',
    add_time: '15166663280',
    cat_id:  '3',
    cat_one_id:  '2',
    cat_two_id:  '1',
    cat_three_id:  '1',
    goods_big_logo:  '',
    goods_id:  '57266',
    goods_name: '创维 65Mk 65英寸  4K超清数据',
    goods_number:  '100',
    goods_price: '3435',
    goods_small_logo:  '',
    goods_weight: '100',
    hot_number:  '0',
    is_promote:  false,
    upd_time: '15166663288',
  }, {
  id: '1122',
  add_time: '15166663280',
  cat_id:  '3',
  cat_one_id:  '2',
  cat_two_id:  '1',
  cat_three_id:  '1',
  goods_big_logo:  '',
  goods_id:  '57266',
  goods_name: '创维 65Mk 65英寸  4K超清数据 创维 65Mk 65英寸  4K超清数据 创维 65Mk 65英寸  4K超清数据 创维 65Mk 65英寸  4K超清数据',
  goods_number:  '100',
  goods_price: '3435',
  goods_small_logo:  '',
  goods_weight: '100',
  hot_number:  '0',
  is_promote:  false,
  upd_time: '15166663288',
}, {
    id: '112122',
    add_time: '15166663280',
    cat_id:  '3',
    cat_one_id:  '2',
    cat_two_id:  '1',
    cat_three_id:  '1',
    goods_big_logo:  '',
    goods_id:  '57266',
    goods_name: '创维 65Mk 65英寸  4K超清数据',
    goods_number:  '100',
    goods_price: '3435',
    goods_small_logo:  '',
    goods_weight: '100',
    hot_number:  '0',
    is_promote:  false,
    upd_time: '15166663288',
  }, {
    id: '11221',
    add_time: '15166663280',
    cat_id:  '3',
    cat_one_id:  '2',
    cat_two_id:  '1',
    cat_three_id:  '1',
    goods_big_logo:  '',
    goods_id:  '57266',
    goods_name: '创维 65Mk 65英寸  4K超清数据',
    goods_number:  '100',
    goods_price: '3435',
    goods_small_logo:  '',
    goods_weight: '100',
    hot_number:  '0',
    is_promote:  false,
    upd_time: '15166663288',
  }]
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
      }, (item: ActivityDataModel) => item.id)

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

  @Builder ProductList(){
    if(this.products.length === 0){
      EmptyView({
        defaultHeight: '30%'
      })
    } else {
        List({
          space: 10
        }){
          ForEach(this.products, (item: ProductDataModel) => {
            ListItem(){
              Column(){
                Image(item.goods_big_logo ? item.goods_big_logo : 'https://img0.baidu.com/it/u=2061919840,1457274808&fm=253&fmt=auto?w=500&h=500')
                  .width('100%')
                  .height(150)

                Column(){
                  Text(item.goods_name)
                    .fontSize(16)
                    .height(70)
                    .maxLines(3)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Row(){
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
          Scroll(){
            Column(){
              // 轮播图
              MySwiper(this.swiperList, this.currentBreakPoint)

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
