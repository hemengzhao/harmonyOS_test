import { router } from '@kit.ArkUI';

@Entry
@Component
struct LoginPage {
  @State phone: string = '';

  @Styles inputBg (){
    .width('100%')
    .height(60)
    .borderRadius(10)
    .backgroundColor('#F1F1F1')
    .margin({top: 37})
  }
  build() {
    Column(){
      Image($r('app.media.loginBg2')).width(314).margin({top: 60})

      Row(){
        Row(){
          Image($r("app.media.login_cn")).width(20).margin({right: 5})
          Image($r('app.media.login_dow')).width(20)
        }
        .padding({left: 20, right: 20})

        TextInput({
          placeholder: $r('app.string.login_placeholder')
        }).type(InputType.PhoneNumber)
          .backgroundColor(Color.Transparent)
          .border({
            width: { left: 1 },
            color: '#E3E3E3'
          })
          .width('75%')
          .borderRadius(0)
      }
      .inputBg()

      TextInput({
        placeholder: $r('app.string.pass_placeholder')
      }).inputBg()

      Column(){
        Text($r('app.string.forgot_pass')).fontColor('#99DC64').fontSize(16)
      }.alignItems(HorizontalAlign.End)
      .width('100%')
      .margin({top: 16})


      Button($r('app.string.login'), {
        type: ButtonType.Normal
      })
        .width('100%')
        .backgroundColor('#99DC64')
        .borderRadius(10)
        .height(50)
        .fontSize(22)
        .margin({top: 60, bottom: 24})
        .onClick(() => {
          router.pushUrl({
            url: 'pages/HomePage'
          })
        })

      Text(){
        Span($r('app.string.no_account'))
        Span($r('app.string.immediately_register')).fontColor('#99DC64')
      }.fontSize(20)

      Row(){
        Checkbox().shape(CheckBoxShape.ROUNDED_SQUARE).selectedColor(0x99DC64)

        Text(){
          Span($r('app.string.i_agree'))
          Span($r('app.string.service_terms')).fontColor('#99DC64')
          Span($r('app.string.login_and'))
          Span($r('app.string.privacy_policy')).fontColor('#99DC64')
        }.fontSize(18)
      }.margin({top: 60 })
    }
    .height('100%')
    .width('100%')
    .padding(20)
  }
}