import QtQuick
import QtQuick.Controls


Item {
    id: control

    //请求某一页
    //page: 页码
    //count: 一页总数
    signal requestPage(int page,int count)

    //需求中要展示的信息：数据总条数，每页条数，当前页，页跳转
    //当前页
    property int pageCurrent: 0
    //数据总数
    property int itemCount: 0
    //总页数
    property int pageCount: itemCount>0?Math.ceil(itemCount/__itemPerPage):0
    //每页条数，这个和box关联的，暂时默认初始化
    property int __itemPerPage: 10
    //页码按钮显示个数
    property int pageButtonCount: 5
    property int __pageButtonHalf: Math.floor(pageButtonCount/2)+1
    property font font
    font{
        pixelSize: 14
        family: "Microsoft YaHei"
    }
    property color textColor: "#666666"
    property color highlightedColor: "#1989FA"
    property color elementBorderColor: "#DCDFE6"
    property int elementHeight: 30
    property alias padding: content_row.padding

    //color: "transparent"
    //border.color: "gray"
    //radius: 4
    implicitHeight: 40
    implicitWidth: content_row.width

    Row{
        id: content_row
        height: control.height
        spacing: 25
        padding: 10

        //页码按钮
        Row{
            spacing: 5
            anchors.verticalCenter: parent.verticalCenter
            //左侧前一页，应该使用图片，这里仅作演示
            PageButton{
                visible: control.pageCount>1
                enabled: control.pageCurrent>1
                anchors.verticalCenter: parent.verticalCenter
                height: 30
                font: control.font
                textColor: control.textColor
                highlightedColor: control.highlightedColor
                text: "<上一页"
                onClicked: {
                    control.calcNewPage(control.pageCurrent-1);
                }
            }
            //中间显示页码
            Row{
                spacing: 5
                anchors.verticalCenter: parent.verticalCenter
                //第一页
                PageButton{
                    visible: control.pageCount>0
                    height: control.elementHeight
                    font: control.font
                    width: Math.max(30,implicitWidth)
                    textColor: control.textColor
                    highlightedColor: control.highlightedColor
                    pageNumber: 1
                    pageCurrent: control.pageCurrent
                    onClicked: {
                        control.calcNewPage(1);
                    }
                }
                Text {
                    //pageCount<btnCount不用显示
                    //当前页在前countHalf页不用显示
                    visible: (control.pageCount>control.pageButtonCount&&
                              control.pageCurrent>control.__pageButtonHalf)
                    text: "..."
                    font: control.font
                    color: control.textColor
                    height: control.elementHeight
                }
                //中间的页码由Repeater根据设置的pageButtonCount创建
                Repeater{
                    id: button_repeator
                    model: (control.pageCount<2)
                           ?0
                           :(control.pageCount>=control.pageButtonCount)
                             ?(control.pageButtonCount-2)
                             :(control.pageCount-2)
                    delegate: PageButton{
                        height: control.elementHeight
                        font: control.font
                        width: Math.max(30,implicitWidth)
                        textColor: control.textColor
                        highlightedColor: control.highlightedColor
                        //在首或者尾相连时，值要连续，避免和首尾重复
                        pageNumber: (control.pageCurrent<=control.__pageButtonHalf)
                                    ?(2+index)
                                    :(control.pageCount-control.pageCurrent<=control.pageButtonCount-control.__pageButtonHalf)
                                      ?(control.pageCount-button_repeator.count+index)
                                      :(control.pageCurrent+2+index-control.__pageButtonHalf)
                        pageCurrent: control.pageCurrent
                        onClicked: {
                            control.calcNewPage(pageNumber);
                        }
                    }
                }
                Text {
                    id: page_moreright
                    //pageCount<btnCount不用显示
                    //当前页在倒数countHalf页不用显示
                    visible: (control.pageCount>control.pageButtonCount&&
                              control.pageCount-control.pageCurrent>control.pageButtonCount-control.__pageButtonHalf)
                    text: "..."
                    font: control.font
                    color: control.textColor
                    height: control.elementHeight
                }
                //最后一页
                PageButton{
                    visible: control.pageCount>1
                    height: control.elementHeight
                    font: control.font
                    width: Math.max(30,implicitWidth)
                    textColor: control.textColor
                    highlightedColor: control.highlightedColor
                    pageNumber: control.pageCount
                    pageCurrent: control.pageCurrent
                    onClicked: {
                        control.calcNewPage(pageNumber);
                    }
                }
            }
            //右侧下一页，应该使用图片，这里仅作演示
            PageButton{
                visible: control.pageCount>1
                enabled: control.pageCurrent<control.pageCount
                anchors.verticalCenter: parent.verticalCenter
                height: 30
                font: control.font
                textColor: control.textColor
                highlightedColor: control.highlightedColor
                text: "下一页>"
                onClicked: {
                    control.calcNewPage(control.pageCurrent+1);
                }
            }
        }
    }

    //翻页计算
    function calcNewPage(page)
    {
        if(!page)
            return;
        let page_num=Number(page);
        //超出范围或者为当前页就返回
        if(page_num<1||page_num>control.pageCount||page_num===control.pageCurrent)
            return;
        control.pageCurrent=page_num;
        control.requestPage(page_num,control.__itemPerPage)
    }
}
