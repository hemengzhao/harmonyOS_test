import { ControlSearchComponent } from '../view/ControlSearchComponent';
import { BottomItem, ControlSearchParameter } from '../viewmodel/ControlSearchParameter';

@Entry
@Component
struct WalkWidgetCard {
  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';
  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'WalkApplicationAbility';
  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';
  private bottomItemList: BottomItem[] = [
    {
      formLinkParam: {
        action: this.ACTION_TYPE,
        abilityName: this.ABILITY_NAME,
        params: {
          message: this.MESSAGE
        }
      },
      title: $r('app.string.widget_explored'),
      icon: $r('app.media.ic_widget_explored')
    },
    {
      formLinkParam: {
        action: this.ACTION_TYPE,
        abilityName: this.ABILITY_NAME,
        params: {
          message: this.MESSAGE
        }
      },
      title: $r('app.string.widget_study'),
      icon: $r('app.media.ic_widget_study')
    },
    {
      formLinkParam: {
        action: this.ACTION_TYPE,
        abilityName: this.ABILITY_NAME,
        params: {
          message: this.MESSAGE
        }
      },
      title: $r('app.string.widget_activity'),
      icon: $r('app.media.ic_widget_activity')
    },
    {
      formLinkParam: {
        action: this.ACTION_TYPE,
        abilityName: this.ABILITY_NAME,
        params: {
          message: this.MESSAGE
        }
      },
      title: $r('app.string.widget_mine'),
      icon: $r('app.media.ic_widget_mine')
    }
  ];
  @State controlSearchParameter: ControlSearchParameter = new ControlSearchParameter('', Color.White,
    Color.White, { color: Color.White }, BlurStyle.COMPONENT_ULTRA_THIN, this.bottomItemList, '',
    $r('app.media.ic_widget_background'), ImageSize.Cover, BlurStyle.COMPONENT_ULTRA_THIN, undefined,
    undefined, undefined, undefined, undefined);

  build() {
    FormLink({
      action: this.ACTION_TYPE,
      abilityName: this.ABILITY_NAME,
      params: {
        message: this.MESSAGE
      }
    }) {
      Row() {
        ControlSearchComponent({ controlSearchParameter: this.controlSearchParameter })
      }
    }
  }
}