import { mediaquery } from '@kit.ArkUI'
import { BasicConstants } from '../Constants/BasicConstants';

@Entry
@Component
struct Page01_media {
  @State message: string = 'Hello World';
  @State  screenDir: string = '竖屏'
  // 是否为横屏
  // @Provide listener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync('(orientation: landscape)')
  @Provide listener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync('(300vp<=width<=600vp)')
  onPortrait = (mediaQueryResult: mediaquery.MediaQueryResult) => {

        this.screenDir = mediaQueryResult.matches ? '横屏' : '竖屏'

  }
  aboutToAppear(): void {
    this.listener.on('change', this.onPortrait)
  }
  build() {
    Column()  {
      Text('媒体查询').fontSize(30)
      Text(`屏幕是为${this.screenDir }`).fontSize(30)
    }
    .height(BasicConstants.Full_WIDTH)
    .width(BasicConstants.Full_HEIGTH)
  }
}