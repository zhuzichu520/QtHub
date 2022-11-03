pragma Singleton
import QtQuick
import "../storage"

QtObject{

    property string colorPrimary: "#1A7EFE"

    property string colorBackground:AppStorage.isDark?"#000011":"#FFFFFF"
    property string colorBackground1:AppStorage.isDark?"#333333":"#F7F7F7"
    property string colorBackground2:AppStorage.isDark?"#444444":"#EFEFEF"

    property string colorItemBackground:AppStorage.isDark?"#000000":"#FFFFFF"
    property string colorDivider: AppStorage.isDark?"#666666":"#DEDEDE"
    property string colorFontPrimary:AppStorage.isDark?"#EEEEEE":"#000000"
    property string colorFontSecondary :AppStorage.isDark?"#999999":"#666666"
    property string colorFontTertiary: AppStorage.isDark?"#BBBBBB":"#999999"

}
