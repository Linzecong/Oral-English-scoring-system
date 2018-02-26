import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "qrc:/GlobalVariable.js" as GlobalColor
import QtGraphicalEffects 1.0
import QtMultimedia 5.0
import SpeechSystem 1.0

Rectangle {
    id:mainrect;
    anchors.fill: parent
    MouseArea{
        anchors.fill: parent
        onClicked: {

        }
    }
    property var score:[]
    property string username;

    function setusername(a){
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

        tihaobox.currentIndex=-1
        tihaobox.currentIndex=0
    }
    function settestscore(a,b){
        score[a]=b
        sendspeechsystem.savetestscore(score.join("@"),username)

    }

    function settihao(a){
        tihaobox.currentIndex=-1
        tihaobox.currentIndex=a
    }

    SpeechSystem{
        id:sendspeechsystem
    }

    Component.onCompleted: {


    }

    Image {
        id:bg
        source: "qrc:/image/bg.jpg"
        anchors.fill: parent


    Rectangle{

        id:head
        z:5
        width:parent.width
        height: parent.height/16*2
        color: "white"
        anchors.top: parent.top
        opacity: 0.3



    }
    Label{
        id:back
        height: head.height
        width:height
        text:"＜"
        color: "white"
        font{
            pixelSize: (head.height)/2
        }
        anchors.left: head.left
        anchors.leftMargin: head.height/70*4
        anchors.verticalCenter: head.verticalCenter
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
        text:"考试评分"
        anchors.centerIn: head
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


    Label{
        id:tihao
        text:"题号："
        anchors.right: tihaobox.left
        anchors.rightMargin: width/3
        anchors.top: head.bottom
        anchors.topMargin: height*2
        verticalAlignment: Text.AlignVCenter
        font{
            bold:false
            pointSize: 12
        }
        color: GlobalColor.Main

    }

    ComboBox {
        id:tihaobox
        model: ["考试1", "考试2", "考试3"]
        width: parent.width/2
        anchors.horizontalCenter: parent.horizontalCenter
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
            if(guanjianzidefen.text.indexOf("空")>=0){
                timubox.text="请先作答！"
                cankaodaanboxtext.text="请先作答！";
            }
        }
    }

    Rectangle{
        id:timu

        height:tihaobox.height*1.6


        anchors.right: cankaodaanbox.right
        anchors.left: cankaodaanbox.left

        anchors.top: tihao.bottom
        anchors.topMargin:timu.height/2

        color:"white"
        opacity: 0.3

        MouseArea{
            anchors.fill: parent
            onClicked: {

            }
        }
    }
    Label{
        id:timubox
        text: "目前，中国杀虫剂和除草剂的年生产能力为75万吨，实际年均产量为40万吨，居世界第二位"
        color: "white"
        wrapMode: Text.Wrap
        width: timu.width
        horizontalAlignment: Text.AlignHCenter
        font{
            pointSize: 12
        }
        anchors.centerIn: timu
    }

    Label{
        id:cankaodaan
        text:"参考答案："
        verticalAlignment: Text.AlignVCenter
        anchors.left: cankaodaanbox.left

        anchors.top: timu.bottom
        anchors.topMargin: height

        font{
            bold:false
            pointSize: 12
        }
        color: GlobalColor.Main

    }

    Rectangle{
        border.width: 1
        border.color: "blue"

        anchors.top: cankaodaan.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: cankaodaan.height
         anchors.bottom: column.top

         id:cankaodaanbox
         color: "white"
         opacity: 0.3
    }

    Text {
        id:cankaodaanboxtext
        text:"Currently,China has the capacity to produce 750,000 tons of pesticide and herbicide a year,with an actual output averaging 400,000 tons a year,ranking the second largest in the world."
        wrapMode: Text.Wrap
        font{
            pointSize: 16
        }
        color:"white"



anchors.fill: cankaodaanbox
anchors.margins: 10


    }

    Rectangle{
        color:"white"
        opacity: 0.2
        anchors.fill: column;
        anchors.margins: -10
    }

    Column{
        id:column

        width: parent.width/3
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: cankaodaan.height/4
        anchors.bottom: kaishiluyin.top
        anchors.bottomMargin: kaishiluyin.height/2
        Label{
            id:guanjianzidefen
            text:"关键字得分：2.0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font{
                pointSize: 13
            }
            color: "white"

        }
        Label{
            id:liulidudefen
            text:"流利度得分：1.5"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font{
                pointSize: 13
            }
            color: "white"
        }
        Label{
            id:yuyidefen
            text:"语义得分：2.0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font{
                pointSize: 13
            }
            color: "white"
        }
        Label{
            id:yuxudefen
            text:"语序得分：1.5"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font{
                pointSize: 13
            }
            color: "white"
        }
        Label{
            id:zonghedefen
            text:"综合评分：1.8"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font{
                bold:false
                pointSize: 15
            }
            color: "white"
        }
        Label{
            id:jiaoshidefen
            text:"教师评分：2.0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font{
                bold:false
                pointSize: 15
            }
            color: "white"
        }
    }

    Rectangle{
        id:kaishiluyin

        height:tihaobox.height*1.5
        width: height

        anchors.horizontalCenter: parent.horizontalCenter

        anchors.bottom: parent.bottom
        anchors.bottomMargin: height/2

        color:GlobalColor.Main
        radius: width/2


        Label{
            text: "▶"
            color: "white"
            font{
                bold:false
                pointSize: 30
            }
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                sendspeechsystem.playsound(username+tihaobox.currentIndex.toString())

            }
        }
        Audio {
            id : audio
        }
    }

}

}
