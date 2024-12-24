import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { formBindingData, formInfo, formProvider } from '@kit.FormKit';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG: string = 'WidgetEventRouterEntryAbility';
const DOMAIN_NUMBER: number = 0xFF00;

export default class MapApplicationAbility extends UIAbility {
  // 要跳转的路径
  private selectPage: string = ''

  // 当前的窗口对象
  private currentWindowStage: window.WindowStage | null = null


  handleFormRouterEvent(want: Want, source: string): void{
    // 判断是否有parameters   以及是否有要更新的key
    if (want.parameters && want.parameters[formInfo.FormParam.IDENTITY_KEY] !== undefined) {
      // curFormId 获取到卡片的编号
      let curFormId = want.parameters[formInfo.FormParam.IDENTITY_KEY].toString();

      // want.parameters.params 对应 postCardAction() 中 params 内容
      let message: string = (JSON.parse(want.parameters?.params as string))?.routerDetail;
      hilog.info(DOMAIN_NUMBER, TAG, `UpdateForm formId: ${curFormId}, message: ${message}`);

      // 定义要更新的卡片数据
      let formData: Record<string, string> = {
        'routerDetail': message + ' ' + source + ' UIAbility', // 和卡片布局中对应
      };

      // 要修改本地存储对象
      let formMsg = formBindingData.createFormBindingData(formData);

      // 执行更新
      formProvider.updateForm(curFormId, formMsg).then((data) => {
        hilog.info(DOMAIN_NUMBER, TAG, 'updateForm success.', JSON.stringify(data));
        console.log('updateForm success !!!!!')
      }).catch((error: BusinessError) => {
        hilog.info(DOMAIN_NUMBER, TAG, 'updateForm failed.', JSON.stringify(error));
        console.log('updateForm failed !!!!!')
      });
    }
  }

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    if(want.parameters !== undefined){
      let params: Record<string, string> = JSON.parse(JSON.stringify(want.parameters))
      this.selectPage = params.targetPage
    }
    this.handleFormRouterEvent(want, 'onCreate')
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {

    if(want.parameters !== undefined){
      let params: Record<string, string> = JSON.parse(JSON.stringify(want.parameters))
      this.selectPage = params.targetPage
    }

    if(this.currentWindowStage !== null){
      this.onWindowStageCreate(this.currentWindowStage)
    }
    this.handleFormRouterEvent(want, 'onNewWant');
  }
  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    let targetPage: string
    switch (this.selectPage){
      case 'Index':
        targetPage = 'pages/Index'
      break
      case  "DataPage":
        targetPage = 'pages/DataPage'
      break
      default:
        targetPage = 'pages/Index'
    }
    if(this.currentWindowStage === null){
      this.currentWindowStage = windowStage
    }

    windowStage.loadContent(targetPage, (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
