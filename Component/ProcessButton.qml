import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
Rectangle{
    id:root
    property string widthVal : "82.5"
    property string heightVal : "82.5"
    property string rectColor:  "#43474a"
    property string textColor:  "#f7f7f7"
    property string text
    property string size : "24"
    property string radiusVal : "10"
    property var action : function () {}
    width:root.widthVal
    height:root.heightVal
    color: root.rectColor
    radius:radiusVal
    Text {
        id:textProcess
        text:root.text
        font.pixelSize: root.size
        anchors.centerIn: parent
        color:root.textColor
    }
    MouseArea{
        id:areaButton
        anchors.fill: parent
        onClicked: {
            action()
        }

        onEntered: filigranActivite()
        onExited: filigranActivite()
    }
    layer.enabled: true
    layer.effect: DropShadow{
        horizontalOffset: 0
        verticalOffset: 4
        radius: 10.0
        samples: 16
        color: "#80000000"
        source: root
    }
    Rectangle{
        id:rectFiligran
        anchors.fill: parent
        color: "gray"
        opacity: 0.3
        visible:false
        radius:radiusVal
        z:1
    }
    function filigranActivite(){
        rectFiligran.visible = !rectFiligran.visible;
    }
}
