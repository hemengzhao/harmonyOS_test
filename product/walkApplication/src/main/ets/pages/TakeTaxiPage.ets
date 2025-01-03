import { callPhone } from '@ohos/common';
import { Size } from '@ohos/hypium';
import { MyTimePicker } from '../view/TimePicker';
import { TopBar } from '../view/TopBar';



@Entry
@Component
struct TakeTaxiPage {
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;

  @State message: string = 'Hello World';
  @State BoxHeight: number = 140
  @State list: string[] = ['1', '2', '3', '4', '5' ]
  @State moveY: number = 0

  @State showType: 'cartListBox' | 'cartResult' = 'cartListBox'
  @State BoxMaxHeight: number = 500


  // 时间选择弹窗
  existApp() {
    console.info('Click the callback in the blank area')
  }
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: MyTimePicker({
      cancel: ()=> {
        this.dialogController?.close()
      },
      confirm: (value: number[])=> {
        this.showType = 'cartResult'
        this.BoxMaxHeight = 400
        this.dialogController?.close()
      }
    }),
    cancel: this.existApp,
    autoCancel: true,
    onWillDismiss:(dismissDialogAction: DismissDialogAction)=> {
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
      console.log("dialog onWillDismiss")
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
        dismissDialogAction.dismiss()
      }
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
        dismissDialogAction.dismiss()
      }
    },
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: px2vp(this.bottomRectHeight) },
    customStyle: false,
    cornerRadius: {
      topLeft: 30,
      topRight: 30,
      bottomLeft: 0,
      bottomRight: 0
    },
    width: '100%',
    shadow: ({ radius: 20, color: Color.Grey, offsetX: 0, offsetY: 0}),
  })


  @Builder CartListBox (){
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }) {
      Column() {
        Column() {

        }.height(8)
        .width(100).borderRadius(4)
        .backgroundColor('#cccccc')
      }.padding({ top: 10, bottom: 15 }).width('100%')

      Column() {
        List({
          space: 10
        }) {
          ForEach(this.list, (item: string) => {
            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.takeCart4')).width(60)
                  Column() {
                    Text('特惠专车').fontSize(18).fontColor('#333333')
                    Text('5分钟').fontSize(16).fontColor('#999999')
                  }
                  .alignItems(HorizontalAlign.Start)
                }.alignItems(VerticalAlign.Center)
                .height('100%')

                Row() {
                  Text() {
                    Span('拼成').fontSize(12)
                    Span('12.5元').fontColor('#FF6B00')
                    Span('未拼成').fontSize(12)
                    Span('16.5元').fontColor('#333333')
                  }.fontSize(14).fontColor('#999999')

                  Checkbox({
                    name: 'cart1',
                    group: 'cartGroup'
                  }).shape(CheckBoxShape.ROUNDED_SQUARE).selectedColor(0x99DC64)
                }
              }
              .height(50)
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

            }.padding(10).width('100%')
          }, (item: string) => item)
        }.height('100%')

      }.flexGrow(1).width('100%')

      Row() {
        Button('出行设置')
          .type(ButtonType.Normal)
          .borderRadius(10)
          .width('40%')
          .backgroundColor('#F1F1F1')
          .fontColor('#666666')
          .fontSize(20)
          .height(50)
        Button('确认呼叫')
          .type(ButtonType.Normal)
          .borderRadius(10)
          .width('50%')
          .backgroundColor('#333333')
          .fontColor('#99DC64')
          .fontSize(20).height(50).onClick(() => {
          if (this.dialogController != null) {
            this.dialogController.open()
          }
        })
      }.justifyContent(FlexAlign.SpaceAround)
      .width('100%').flexShrink(0)
      .height(70)

    }.height('100%')
    .width('100%')


  }


  @Builder CartResult(){
    Column(){
      Column() {
        Column() {

        }.height(8)
        .width(100).borderRadius(4)
        .backgroundColor('#cccccc')
      }.padding({ top: 10, bottom: 15 }).width('100%')

      Row() {
        Column() {
          Text() {
            Span('今天12:35 ').fontSize(16)
            Span('未拼成').fontSize(14).fontColor('#999999')
          }
          Text('陕A 7D75X').fontSize(16).margin({ top: 4 })
          Text('黑色 丰田凯美瑞').fontSize(14).fontColor('#666666').margin({ top: 4 })
        }.alignItems(HorizontalAlign.Start)

        Image($r('app.media.result_cart'))
          .width(80)
          .height(50)
          .objectFit(ImageFit.Contain)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })

      Divider().strokeWidth(1).color('#F1F3F5')
      // Driver info section
      Row() {
        Row({ space: 8 }) {
          Stack({
            alignContent: Alignment.Bottom
          }){
            Image($r('app.media.result_acvue'))
              .width(50)
              .height(50)
              .borderRadius(25)
              Row(){
                Text('4.5').fontSize(10)
                Image($r('app.media.result_star')).width(10)
              }.backgroundColor(Color.White).borderRadius(5).padding({
                left: 5,
                right: 5
              })

          }.backgroundColor('#F6F1EA').borderRadius(25)


          Column() {
            Text('王师傅').fontSize(16).fontWeight(FontWeight.Medium)
            Row({ space: 4 }) {
              Image($r('app.media.result_king')).width(16).height(16)
              Text('钻石司机').fontSize(14).fontColor('#666666')
            }.margin({ top: 4 })
          }.alignItems(HorizontalAlign.Start)
        }

        Row({ space: 16 }) {
          Image($r('app.media.result_phone'))
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor('#313131').onClick(() => {
              callPhone('18137930317')
            })

          Badge({
            count: 3,
            position: BadgePosition.RightTop,
            style: { color: Color.White, }
          }){
            Image($r('app.media.result_mess'))
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#313131')
          }
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })

      Divider().strokeWidth(1).color('#F1F3F5')

      // Location info (placeholder)
      Column({space: 30}) {
        Row() {
          Circle({ width: 12, height: 12 }).borderRadius(6)
            .fill('#FF6B00').shadow({ radius: 20, color: '#FF6B00', offsetX: 0, offsetY: 0})
          Column(){
            Text('出发地').fontSize(16).fontColor('#999999')
            Text('西安电子科技大学国家科技园E座').fontColor('#333333')
              .fontSize(16)
          }.alignItems(HorizontalAlign.Start).margin({ left: 12 })

        }.margin({ top: 12 })

        Row() {
          Circle({ width: 12, height: 12 }).borderRadius(6)
            .fill('#00FF00').shadow({ radius: 20, color: '#00FF00', offsetX: 0, offsetY: 0})

          Column(){
            Text('目的地').fontSize(16).fontColor('#999999')
            Text('万达广场(高新店)').fontSize(16).fontColor('#333333')

          }.alignItems(HorizontalAlign.Start).margin({ left: 12 })

        }.margin({ top: 12 })
      }
      .width('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      Row(){
        Button('确认司机到达')
          .type(ButtonType.Normal)
          .borderRadius(10)
          .width('80%')
          .backgroundColor('#333333')
          .fontColor('#99DC64')
          .fontSize(20)
          .height(50)
      }

    }
    .width('100%')
    .height('100%')
  }
  build() {
    RelativeContainer() {
      Column() {
        Button('asda').margin({ top: 200 }).onClick(() => {
          console.log('diaasdas')
        })
      }.backgroundColor(Color.Green)
      .width('100%')
      .height('100%')
      .alignRules({
        'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
      })

      Column() {
        TopBar({
          isBack: true
        })
      }
      Flex({
        direction: FlexDirection.Column,
        justifyContent: FlexAlign.Center,
        alignItems: ItemAlign.Center
      }) {
        if(this.showType === 'cartListBox'){
          this.CartListBox()
        } else if(this.showType === 'cartResult'){
          this.CartResult()
        }
      }.height(this.BoxHeight)
      .backgroundColor(Color.White)
      .width('100%')
      .borderRadius({
        topLeft: 30,
        topRight: 30
      })
      .onTouch((event?: TouchEvent) => {
        console.log('event.type.toString()')
        if(event){
          const nowMoveY = event.touches[0].windowY
          if (event.type === TouchType.Down) {
            console.log('Down')
          }

          if (event.type === TouchType.Up) {
            console.log('Up')
            this.BoxHeight = this.BoxHeight > 250 ? this.BoxMaxHeight : 160
          }
          if (event.type === TouchType.Move) {
            console.log('Move')
            const diff = this.moveY -  nowMoveY
            const h = this.BoxHeight + diff
            this.BoxHeight  =   h > this.BoxMaxHeight  ? this.BoxMaxHeight : h < 160 ? 160 : h
          }
          this.moveY = event.touches[0].windowY
        }
      })
      .alignRules({
        'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom },
      })

    }
    .height('100%')
    .width('100%').padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }
}