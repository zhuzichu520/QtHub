pragma Singleton

import QtQuick 2.15

ListModel{
    Component.onCompleted: {
        append({name:"颜色取色器",router:Router.window_colorpicker})
        append({name:"JSON格式化",router:Router.window_jsonparser})
        append({name:"URL decode",router:Router.window_urldecode})
        append({name:"二维码工具",router:Router.window_qrcode})
    }
}
