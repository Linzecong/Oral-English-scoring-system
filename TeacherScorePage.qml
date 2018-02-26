import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "qrc:/GlobalVariable.js" as GlobalColor
import QtGraphicalEffects 1.0
import SpeechSystem 1.0

Rectangle {
    id:mainrect;
    anchors.fill: parent

    MouseArea{
        anchors.fill: parent
        onClicked: {

        }
    }

    SpeechSystem{
        id:sendspeechsystem
    }

    property string username;

    function setusername(a){
        score=[]
        username=a;
        var list=sendspeechsystem.gettestscore(username).split("@")

        if(sendspeechsystem.gettestscore(username)==="NO"){
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
            score.push("关键字得分：空###流利度得分：空###语义得分：空###语序得分：空###综合评分：空###教师尚未评分");
        }
        else{
            score.push(list[0]);
            score.push(list[1]);
            score.push(list[2]);
        }

        tihaobox.currentIndex=2
        tihaobox.currentIndex=0
    }

    property var score:[]

    function settestscore(a,b){
        score[a]=b
        sendspeechsystem.savetestscore(score.join("@"),username)
        tihaobox.currentIndex=-1
        tihaobox.currentIndex=a
    }

    function settihao(a){
        tihaobox.currentIndex=-1
        tihaobox.currentIndex=a
    }

    Component.onCompleted: {

    }


    Rectangle{

        id:head
        z:5
        width:parent.width
        height: parent.height/16*2
        color: GlobalColor.Main
        anchors.top: parent.top
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            radius: 10
            color: GlobalColor.Main
        }
        Label{
            id:back
            height: parent.height
            width:height
            text:"＜"
            color: "white"
            font{
                pixelSize: (head.height)/2
            }
            anchors.left: parent.left
            anchors.leftMargin: head.height/70*4
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            MouseArea{
                anchors.fill: parent
                onClicked: {
                     mainrect.parent.x=mainrect.parent.height
                }
            }
        }



        Label{
            id:headname
            text:"评分"
            anchors.centerIn: parent
            font{
                bold:false
                pointSize: 20
            }
            color: "white";
            MouseArea{
                anchors.fill: parent
                onClicked: {

                }
            }
        }


    }


    Label{
        id:tihao
        text:"题号："
        anchors.left: parent.left
        anchors.leftMargin: width/2
        anchors.top: head.bottom
        anchors.topMargin: height*2
        verticalAlignment: Text.AlignVCenter
        font{
            bold:false
            pointSize: 14
        }
        color: GlobalColor.Main

    }

    ComboBox {
        id:tihaobox
        model: ["考试1", "考试2", "考试3"]
        width: parent.width/2.5
        anchors.left: tihao.right
        anchors.leftMargin: tihao.width/2
        anchors.verticalCenter: tihao.verticalCenter

        height:tihao.height*2
        onCurrentTextChanged: {
            if(currentText=="考试1"){
                timubox.text="为保证广大干旱地区的粮食供应和消灭贫穷，中国迫切需要发展有效利用水资源的农业。"
                guanjianzidefen.text=score[0].split("###")[0]
                liulidudefen.text=score[0].split("###")[1]
                yuyidefen.text=score[0].split("###")[2]
                yuxudefen.text=score[0].split("###")[3]
                zonghedefen.text=score[0].split("###")[4]
                jiaoshidefen.text=score[0].split("###")[5]
                cankaodaanboxtext.text="China has a pressing need to develop agriculture which uses water efficiently in a bid to ensure security of food supplies and alleviate poverty in its vast arid areas."
            }
            if(currentText=="考试2"){
                timubox.text="1994年世界银行发表一份报告便得出结论：招收女童入学很可能是今日发展中国家唯一最有效的消除贫困的政策。"
                guanjianzidefen.text=score[1].split("###")[0]
                liulidudefen.text=score[1].split("###")[1]
                yuyidefen.text=score[1].split("###")[2]
                yuxudefen.text=score[1].split("###")[3]
                zonghedefen.text=score[1].split("###")[4]
                jiaoshidefen.text=score[1].split("###")[5]
                cankaodaanboxtext.text="A 1994 World Bank report concluded that enrolling girls in school was probably the single most effective anti-poverty policy in the developing world today."
            }
            if(currentText=="考试3"){
                timubox.text="我们衷心希望这种类型的活动可以促进和加强中国和英国之间的教育交流与合作"
                guanjianzidefen.text=score[2].split("###")[0]
                liulidudefen.text=score[2].split("###")[1]
                yuyidefen.text=score[2].split("###")[2]
                yuxudefen.text=score[2].split("###")[3]
                zonghedefen.text=score[2].split("###")[4]
                jiaoshidefen.text=score[2].split("###")[5]
                cankaodaanboxtext.text="We sincerely hope that this type of activity can promote and strengthen educational exchanges and cooperation between China and the United Kingdom."

            }
        }
    }

    Rectangle{
        id:chakanpingfen

        height:tihao.height*2
        width: height*2.7

        anchors.right: parent.right
        anchors.rightMargin: width/4

        anchors.verticalCenter: tihao.verticalCenter
        radius: width/2.5
        color:GlobalColor.ShareMSG
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            radius: 5
            color: GlobalColor.ShareMSG
        }
        Label{
            text: "考生录音"
            color: "white"
            font{
                bold:false
                pointSize: 14
            }
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                sendspeechsystem.playsound(username+tihaobox.currentIndex.toString())
            }
        }
    }






    Rectangle{
        id:timu

        height:tihaobox.height*1.6

        anchors.right: cankaodaanbox.right
        anchors.left: cankaodaanbox.left

        anchors.top: tihao.bottom
        anchors.topMargin:timu.height

        color:"white"
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            radius: 5
            color: GlobalColor.ShareMSG
        }
        Label{
            id:timubox
            text: "目前，中国杀虫剂和除草剂的年生产能力为75万吨，实际年均产量为40万吨，居世界第二位"
            wrapMode: Text.Wrap
            width:parent.width
            horizontalAlignment: Text.AlignHCenter
            color: "grey"
            font{
                pointSize: 12
            }
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {

            }
        }
    }


    Label{
        id:cankaodaan
        text:"参考答案："
        verticalAlignment: Text.AlignVCenter
        anchors.left: tihao.left

        anchors.top: timu.bottom
        anchors.topMargin: height*1.2

        font{
            bold:false
            pointSize: 14
        }
        color: GlobalColor.Main

    }


    Rectangle{
        border.width: 2
        border.color: "blue"

        anchors.top: cankaodaan.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: cankaodaan.height
         anchors.bottom: column.top

         id:cankaodaanbox
        TextArea {
            id:cankaodaanboxtext
            text:"Currently,China has the capacity to produce 750,000 tons of pesticide and herbicide a year,with an actual output averaging 400,000 tons a year,ranking the second largest in the world."
            wrapMode: Text.Wrap
            font{
                pointSize: 16
            }
            color:"grey"
            readOnly:false


            anchors.fill: parent





        }
    }






    Column{
        id:column
        width: parent.width/2
        anchors.left: cankaodaanbox.left
        spacing: cankaodaan.height

        anchors.bottom: parent.bottom
        anchors.bottomMargin: head.height/3

        Label{
            id:guanjianzidefen
            text:"关键字得分：2.0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font{
                pointSize: 13
            }
            color: GlobalColor.Main
        }
        Label{
            id:liulidudefen
            text:"流利度得分：1.5"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font{
                pointSize: 13
            }
            color: GlobalColor.Main
        }
        Label{
            id:yuyidefen
            text:"语义得分：2.0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font{
                pointSize: 13
            }
            color: GlobalColor.Main
        }
        Label{
            id:yuxudefen
            text:"语序得分：1.5"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font{
                pointSize: 13
            }
            color: GlobalColor.Main
        }
    }

    Column{

        width: parent.width/2
        anchors.left: parent.horizontalCenter
        anchors.top: column.top

        anchors.bottom: parent.bottom
        anchors.bottomMargin: head.height/2
        spacing: cankaodaan.height/1.5
        Label{
            id:zonghedefen
            text:"综合评分：1.8"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font{
                bold:false
                pointSize: 14
            }
            color: GlobalColor.Main
        }


        Label{
            id:jiaoshidefen
            text:"教师评分："
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font{
                bold:false
                pointSize: 14
            }
            color: GlobalColor.Main
        }

        TextField {
            id:jiaoshipingfenbox
            placeholderText: "请输入评分..."

            width: mainrect.width/3
            height:jiaoshidefen.height*1.3

        }


        Rectangle{
            id:queren

            width: jiaoshipingfenbox.width
            height:jiaoshidefen.height*1.5
            anchors.horizontalCenter: jiaoshipingfenbox.horizontalCenter

            color:GlobalColor.ShareMSG
            radius: height/2.5
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 5
                color: GlobalColor.ShareMSG
            }
            Label{
                text: "确认"
                color: "white"
                font{
                    bold:false
                    pointSize: 12
                }
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    var str="";


                    str+=guanjianzidefen.text+"###"
                    str+=liulidudefen.text+"###"
                    str+=yuyidefen.text+"###"
                    str+=yuxudefen.text+"###"
                    str+=zonghedefen.text+"###"

                    str+="教师评分："+jiaoshipingfenbox.text


                    settestscore(tihaobox.currentIndex,str)
                }
            }
        }



    }









}
