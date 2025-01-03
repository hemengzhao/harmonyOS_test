// import需要的模块
import { call, observer } from '@kit.TelephonyKit';
import { BusinessError } from '@kit.BasicServicesKit';

export function callPhone  (phone: string){
  // 调用查询能力接口
  let isSupport = call.hasVoiceCapability();
  if (isSupport) {
    // 如果设备支持呼叫能力，则继续跳转到拨号界面，并显示拨号的号码
    call.makeCall(phone, (err: BusinessError) => {
      if (!err) {
        console.log("make call success.");
      } else {
        console.log("make call fail, err is:" + JSON.stringify(err));
      }
    });
    // 订阅通话业务状态变化（可选）
    class SlotId {slotId: number = 0}
    class CallStateCallback {
      state: call.CallState = call.CallState.CALL_STATE_UNKNOWN;
      number: string = "";
    }
    let slotId: SlotId = {slotId: 0}
    observer.on("callStateChange", slotId, (data: CallStateCallback) => {
      console.log("call state change, data is:" + JSON.stringify(data));
    });
  } else {
    AlertDialog.show(
      {
        title: '警告',
        message: '本设备暂不支持拨打电话',
        autoCancel: true,
        alignment: DialogAlignment.Center,
        offset: { dx: 0, dy: -20 },
        gridCount: 3,
        cancel: () => {
          console.info('Closed callbacks')
        },
        onWillDismiss:(dismissDialogAction: DismissDialogAction)=> {
          console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
          console.log("dialog onWillDismiss")
          if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
            dismissDialogAction.dismiss()
          }
          if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
            dismissDialogAction.dismiss()
          }
        }
      }
    )
  }
}