import { common, Want } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { router } from "@kit.ArkUI";

@Component
export struct Personal{
  private context?: common.UIAbilityContext

  aboutToAppear() {
    this.context = getContext(this) as common.UIAbilityContext
  }
  purchase = () => {

    // HAP跳转，模拟器不起作用，真机待实验
    if(this.context){
      this.context.startAbility({
        bundleName: 'com.example.myapplication',
        abilityName: 'walkApplication'
      }).then(() => {
        console.info( 'start audio ability success')
      }).catch((error: BusinessError) => {
        console.error( 'start audio ability failed, error: ' + JSON.stringify(error))
      })
    }


    // try {
    //   let want: Want = {
    //     bundleName: 'com.example.myapplication',
    //     abilityName: 'walkApplication'
    //   };
    //   const context =  getContext(this) as common.UIAbilityContext
    //   context.startAbility(want, (err: BusinessError) => {
    //     if (err.code) {
    //       // 处理业务逻辑错误
    //       console.error(`startAbility failed, code is ${err.code}, message is ${err.message}`);
    //       return;
    //     }
    //     // 执行正常业务
    //     console.info('startAbility succeed');
    //     // router.pushUrl({
    //     //   url: 'pages02/PayPage'
    //     // })
    //   })
    // } catch (err) {
    //   // 处理入参错误异常
    //   let code = (err as BusinessError).code;
    //   let message = (err as BusinessError).message;
    //   console.error(`startAbility failed, code is ${code}, message is ${message}`);
    // }
  }
  build() {
    Column(){
      Text('我的页面')
      Button('跳转到打车APP123').onClick(() => {
        console.log('跳转到打车APP')
        // router.pushUrl({
        //   url: '@bundle:com.example.myapplication/product/walkApplication/ets/pages/Index'
        // })

        this.purchase()
        // router.pushUrl({
        //   url: '@bundle:com.example.myapplication/product/WalkApplicationAbility/ets/pages/Index'
        // })
        // postCardAction(this, {
        //   action: 'router',
        //   abilityName: 'WalkApplicationAbility',
        //   params: {
        //     targetPage: 'Index'
        //   }
        // })
        // postCardAction(this, {
        //   action: 'router',
        //   abilityName: 'mapApplication',
        //   params: {
        //     targetPage: 'Index'
        //   }
        // })


      })
    }
  }
}