import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "./Component"
ApplicationWindow {
    width: 400
    height: 700
    maximumWidth: width
    maximumHeight: height
    minimumWidth: width
    minimumHeight: height
    visible: true
    title: qsTr("Calculator")

    property bool lastInputWasOperation : false         //en son operatör girildiyse true oluyor

    function clear(){
        textProcessValue.text = ""
        textQuestionValue.text = ""
        lastInputWasOperation = false
    }

    function addNumber(number){
        if(textProcessValue.text !== ""){
            if(textProcessValue.text.search("=") > -1)
                textProcessValue.text = ""
        }

        if(lastInputWasOperation){
            textQuestionValue.text = number
            lastInputWasOperation = false
        }else{
            textQuestionValue.text += number
        }
    }

    function performOperation(op){
        if(lastInputWasOperation)
        {
            textProcessValue.text = textProcessValue.text.slice(0,-2) + op + " ";
            return;
        }

        if(textProcessValue.text !== ""){
            if(textProcessValue.text.search("=") > -1)
                textProcessValue.text = ""
            textProcessValue.text += textQuestionValue.text + " " + op + " ";
        }else{
            if(textQuestionValue.text === "")
                textProcessValue.text = "0 " + op +" ";
            else
                textProcessValue.text = textQuestionValue.text + " " + op + " ";
        }
        lastInputWasOperation = true
    }
    function calculate(){
        try{
            if(textProcessValue.text.search("=") > -1)
            {
                clear()
                return null;
            }

            let step = textProcessValue.text.replace(/x/g,"*");
            step = step.replace(/,/g,".");
            let result = eval(step);
            return result.toString().replace(".", ",");
        }catch(e){
            return "ERROR!!";
        }
    }

    Rectangle{
        anchors.fill: parent
        color:"#2a2c30"
        Rectangle{
            id:inputs
            width:parent.width
            height: parent.height*0.3
            color:"#2a2c30"
            Rectangle{
                id:rectProcessValue
                width:parent.width
                height: parent.height*0.4
                color:"transparent"
                Text {
                    id:textProcessValue
                    text: ""
                    font.pixelSize: 40
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.margins:30
                    color:"#f5f4f4"
                }
            }

            Rectangle{
                id:rectQuestionValue
                width:parent.width
                height: parent.height*0.6
                color:"transparent"
                anchors.top:rectProcessValue.bottom
                Text {
                    id:textQuestionValue
                    text: ""
                    font.pixelSize: 70
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.margins:30
                    color:"#f5f4f4"
                }
            }
        }
        Rectangle{
            id:rectButtons
            anchors.top: inputs.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            color:"#333638"
            radius:10

            GridLayout{
                columns: 4
                rows:5
                anchors.fill: parent
                anchors.margins: 5

                ProcessButton{
                    text:"C"
                    rectColor: "#3a3d3f"
                    action:function(){
                        clear()
                    }
                }
                ProcessButton{
                    text:"/"
                    rectColor: "#b57826"
                    action:function(){
                        performOperation("/")
                    }
                }
                ProcessButton{
                    text:"x"
                    rectColor: "#b57826"
                    action:function(){
                        performOperation("x")
                    }
                }
                ProcessButton{
                    text:"-"
                    rectColor: "#b57826"
                    action:function(){
                        performOperation("-")
                    }
                }
                ProcessButton{
                    text:"7"
                    action:function(){
                        addNumber("7")
                    }
                }
                ProcessButton{
                    text:"8"
                    action:function(){
                        addNumber("8")
                    }
                }
                ProcessButton{
                    text:"9"
                    action:function(){
                        addNumber("9")
                    }
                }
                ProcessButton{
                    text:"+"
                    Layout.rowSpan: 2
                    heightVal: "175"
                    rectColor: "#b57826"
                    action: function(){
                        performOperation("+")
                    }
                }
                ProcessButton{
                    text:"4"
                    action:function(){
                        addNumber("4")
                    }
                }
                ProcessButton{
                    text:"5"
                    action:function(){
                        addNumber("5")
                    }
                }
                ProcessButton{
                    text:"6"
                    action:function(){
                        addNumber("6")
                    }
                }

                ProcessButton{
                    text:"1"
                    action:function(){
                        addNumber("1")
                    }
                }
                ProcessButton{
                    text:"2"
                    action:function(){
                        addNumber("2")
                    }
                }
                ProcessButton{
                    text:"3"
                    action:function(){
                        addNumber("3")
                    }
                }
                ProcessButton{
                    text:"="
                    Layout.rowSpan: 2
                    heightVal: "175"
                    rectColor: "#b57826"
                    action: function(){
                        if (!lastInputWasOperation) {
                            textProcessValue.text += textQuestionValue.text;
                            let result = calculate();
                            textProcessValue.text = result !== null ? textProcessValue.text + " =" : "";
                            textQuestionValue.text = result !== null ? result : "0";
                            lastInputWasOperation = false;
                        }
                    }
                }
                ProcessButton{
                    text:"0"
                    widthVal: "175"
                    Layout.columnSpan: 2
                    action: function(){
                        addNumber("0")
                    }
                }
                ProcessButton{
                    text:","
                    action:function(){
                        if(lastInputWasOperation){
                            textQuestionValue.text = "0,"
                            lastInputWasOperation = false
                        } else if(!textQuestionValue.text.includes(",")) {
                            textQuestionValue.text += ","
                        }
                    }
                }
            }
        }
    }
}
