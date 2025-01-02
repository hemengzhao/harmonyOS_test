import { router } from '@kit.ArkUI';

@Entry
@Component
struct MyPage {
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;

  @State memberLevel: string = '里程会员'

  @Builder MenuGrid(icon: Resource, text: string, badge?: number) {
    Column() {
      Badge({
        count: badge,
        position: BadgePosition.RightTop,
        style: { color: Color.White  }
      }) {
        Image(icon)
          .width(48)
          .height(48)
      }
      Text(text)
        .fontSize(14)
        .fontColor('#333333')
        .margin({ top: 8 })
    }
  }

  build() {
    Column(){
      Row() {
        Text('<')
          .fontSize(20)
          .fontWeight(FontWeight.Medium).onClick(() => {
            router.back()
          })

        Text('我的')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)

        Image($r('app.media.my_icon11'))
          .width(24)
          .height(24)
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left: 20,
        right: 20,
        bottom: 10
      })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

      Column(){
        Scroll(){
          Column({space: 20}) {
            // Header
            Row({ space: 16 }) {
              Image($r('app.media.home_my'))
                .width(60)
                .height(60)
                .borderRadius(30)
              Text('假面')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)


            // Member Card
            Column() {
              Column(){
                Image($r('app.media.vip')).width('90%').margin({
                  top: 20
                })
              }.backgroundImage($r('app.media.vipbg'))
              .backgroundImageSize({
                width: '100%',
                height: '100%'
              })
              .width('100%')
              .height(60)

              // Member Benefits
              GridRow({columns: 4, }) {
                GridCol() {
                  Column() {
                    Badge({
                      value: '特惠88',
                      position: BadgePosition.RightTop,
                      style: { color: '#FFF', fontSize: 10 }
                    }) {
                      Image($r('app.media.my_icon1')).width(30)
                    }

                    Text('加油8折起')
                      .fontSize(14)

                  }
                }

                GridCol() {
                  Column(){
                    Image($r('app.media.my_icon2')).width(30)
                    Text('行程意外险')
                      .fontSize(14)
                  }

                }

                GridCol() {
                  Column(){
                    Image($r('app.media.my_icon3')).width(30)
                    Text('会员套餐')
                      .fontSize(14)
                  }

                }

                GridCol() {
                  Column(){
                    Image($r('app.media.my_icon4')).width(30)
                    Text('更多权益')
                      .fontSize(14)
                  }
                }
              }
              .padding(16)
            }
            .width('100%')
            .backgroundColor('#FfF')
            .borderRadius(16)

            // Function Menu

            GridRow({columns: 4,gutter: {
              x: 20
            }  }) {

              GridCol() {
                this.MenuGrid($r('app.media.my_icon5'), '订单')
              }
              GridCol() {
                this.MenuGrid($r('app.media.my_icon6'), '钱包')
              }
              GridCol() {
                this.MenuGrid($r('app.media.my_icon7'), '客服', 1)
              }
              GridCol() {
                this.MenuGrid($r('app.media.my_icon8'), '设置')
              }
            }
            .padding(16)
            .margin({ top: 16 })
            .backgroundColor('#FfF')
            .borderRadius(16)

            // Coupon Info
            Column() {
              Text('我的卡券')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .margin({ bottom: 16 }).textAlign(TextAlign.Start).width('100%')

              Row() {
                Column() {
                  Text('5').fontSize(20).fontWeight(FontWeight.Bold)
                  Text('优惠券').fontSize(14).fontColor('#333333')
                }
                Column() {
                  Text('1').fontSize(20).fontWeight(FontWeight.Bold)
                  Text('出行卡').fontSize(14).fontColor('#333333')
                }
                Column() {
                  Text('6').fontSize(20).fontWeight(FontWeight.Bold)
                  Text('积分').fontSize(14).fontColor('#333333')
                }
                Column() {
                  Text('0').fontSize(20).fontWeight(FontWeight.Bold)
                  Text('福利金').fontSize(14).fontColor('#333333')
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .padding(16)
            .backgroundColor('#FfF')
            .borderRadius(16)

            // Promotion Cards
            Row() {
              Column() {
                Text('邀请好友').textAlign(TextAlign.Start).width('100%')
                  .fontSize(16)
                  .margin({ top: 8 })
                Text('赚奖金').textAlign(TextAlign.Start).width('100%')
                  .fontSize(14)
                  .fontColor('#FF6B00')
                Image($r('app.media.my_icon9'))
                  .width('90%').margin({top: 20})
              }
              .backgroundColor(Color.White)
              .borderRadius(12)
              .width('48%')     .padding(10)
              .height(190)

              Column() {

                Text('成为司机').textAlign(TextAlign.Start).width('100%')
                  .fontSize(16)
                  .margin({ top: 8 })
                Text('跑车赚钱').textAlign(TextAlign.Start).width('100%')
                  .fontSize(14)
                  .fontColor('#99DC64')
                Image($r('app.media.my_icon10'))
                  .width('80%').margin({top: 20})
              }
              .backgroundColor(Color.White)
              .padding(10)
              .borderRadius(12)
              .width('48%')
              .height(190)
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

          }
          .padding({
            left: 20,
            right: 20
          })

        }.height('100%').width('100%')
      }.flexGrow(1).backgroundColor('#F5F5F5').expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])


    }.width('100%').height('100%')

  }
}