pragma Singleton
import QtQuick
import QtQuick.Controls

import "../storage"

QtObject{

    property string colorPrimary: AppStorage.colorPrimary

    property string colorBackground:AppStorage.isDark?"#000011":"#FFFFFF"
    property string colorBackground1:AppStorage.isDark?"#333333":"#F7F7F7"
    property string colorBackground2:AppStorage.isDark?"#444444":"#EFEFEF"

    property string colorItemBackground:AppStorage.isDark?"#000000":"#FFFFFF"
    property string colorDivider: AppStorage.isDark?"#666666":"#DEDEDE"
    property string colorFontPrimary:AppStorage.isDark?"#EEEEEE":"#000000"
    property string colorFontSecondary :AppStorage.isDark?"#999999":"#666666"
    property string colorFontTertiary: AppStorage.isDark?"#BBBBBB":"#999999"

    property int windowRadius

    Component.onCompleted: {
        windowRadius =  Qt.binding(function(){
            if(AppStorage.windowRadiusStep === 0){
                return 0
            }
            if(AppStorage.windowRadiusStep === 1){
                return 5
            }
            if(AppStorage.windowRadiusStep === 2){
                return 10
            }
            return 5
        })
    }
}
