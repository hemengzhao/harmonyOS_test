import { common } from "@kit.AbilityKit";
import { abilityAccessCtrl, bundleManager, Permissions } from '@kit.AbilityKit';
import { BusinessError } from "@kit.BasicServicesKit";
/**
 * 申请用户授予权限
 * @param permissions   ['ohos.permission.LOCATION']
 * @param context
 * */
export function reqPermissionsFromUser(permissions: Array<Permissions>, context: common.UIAbilityContext): Promise<number>  {
  let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
  return new Promise((resolve: (value: number) => void, reject: () => void) => {
    atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作
          console.log('用户授权，可以继续访问')
          resolve(1)
        } else {
          // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
          console.log('用户拒绝授权')
          resolve(0)
          return;
        }
      }
    }).catch((err: BusinessError) => {
      resolve(-1)
      console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    })

  })
}