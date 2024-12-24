import { formBindingData, FormExtensionAbility, formInfo, formProvider } from '@kit.FormKit';
import { Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG: string = 'EntryFormAbility';
const DOMAIN_NUMBER: number = 0xFF00;
export default class MapApplicationFormAbility extends FormExtensionAbility {

  onAddForm(want: Want) {
    // Called to return a FormBindingData object.
    let formData = '';
    return formBindingData.createFormBindingData(formData);
  }

  onCastToNormalForm(formId: string) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  onUpdateForm(formId: string) {
    // Called to notify the form provider to update a specified form.
  }

  onFormEvent(formId: string, message: string) {
    // Called when a specified message event defined by the form provider is triggered.

    // Called when a specified message event defined by the form provider is triggered.
    hilog.info(DOMAIN_NUMBER, TAG, `FormAbility onFormEvent, formId = ${formId}, message: ${JSON.stringify(message)}`);

    // 定义要存储到本地键值对
    class FormDataClass {
      routerDetail: string = 'routerDetail Update By message'; // 和卡片布局中对应
    }

    // 实例化对象，保存到本地的对象
    let formData = new FormDataClass();
    // 得到要更新到本地formInfo
    let formInfo: formBindingData.FormBindingData = formBindingData.createFormBindingData(formData);
    // updateForm用于更新卡片数据
    formProvider.updateForm(formId, formInfo).then(() => {
      hilog.info(DOMAIN_NUMBER, TAG, 'FormAbility updateForm success.');
    }).catch((error: BusinessError) => {
      hilog.info(DOMAIN_NUMBER, TAG, `Operation updateForm failed. Cause: ${JSON.stringify(error)}`);
    })

  }

  onRemoveForm(formId: string) {
    // Called to notify the form provider that a specified form has been destroyed.
  }

  onAcquireFormState(want: Want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }
};