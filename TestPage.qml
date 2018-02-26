import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "qrc:/GlobalVariable.js" as GlobalColor
import QtGraphicalEffects 1.0
import SpeechSystem 1.0
import QtMultimedia 5.0
Rectangle {
    id:mainrect;
    anchors.fill: parent

    MouseArea{
        anchors.fill: parent
        onClicked: {

        }
    }
    property string username;
    property int hack:0
    function setusername(a){
        username=a;
    }
    property var isdone: []

    Component.onCompleted: {
        isdone.push(0)
        isdone.push(0)
        isdone.push(0)
    }

    function reset(){
        mask.visible=true
        tihaobox.enabled=true
        luyinarea.enabled=true
        luyintext.text="答"
        mask2.visible=false
    }

    function reset2(){
        tihaobox.currentIndex=-1
        tihaobox.currentIndex=0
    }




    SpeechSystem{
        id:sendspeechsystem
        property string enstr
        property string zhstr

        onStatueChanged: {


            if(Statue==""){
                if(hack==0){

                    timubox.text="语音出错，上传失败....或网络出现问题"
                    shangchuantext.text="！"
                }





                }
            else{
                if(Statue=="transdone"){
                    shangchuantext.text="√"
                    zhstr=sendspeechsystem.getTransSpeech()
                    var standerzh=timubox.text
                    var standeren=cankaodaanbox.text

                    //关键字评分
                    var guanjianzi=3
                    var gjzdf=0.0
                    for(var i=0;i<standerzh.length;i++){
                        for(var j=0;j<zhstr.length;j++){
                            if(standerzh[i]===zhstr[j])
                                guanjianzi++;
                        }
                    }
                    gjzdf=((guanjianzi+5)/(standerzh.length+5))*2
                    var gjzdf0=gjzdf
                    if(gjzdf0<0.3)
                        gjzdf=0.0

                    if(gjzdf0>0.3)
                        gjzdf=0.5

                    if(gjzdf0>0.5)
                        gjzdf=1.0
                    if(gjzdf0>0.7)
                        gjzdf0=1.5
                    if(gjzdf0>1.0)
                        gjzdf=2.0

                    //语义得分
                    var yuyi=3
                    var yydf=0.0
                    var standerenlist=standeren.split(" ");
                    var enstrlist=enstr.split(" ");
                    for(var i1=0;i1<standerenlist.length;i1++){
                        for(var j1=0;j1<enstrlist.length;j1++){
                            if(standerzh[i1]===zhstr[j1])
                                yuyi++;
                        }
                    }
                    yydf=((yuyi+5)/(standerenlist.length+5))*2
                    var yydf0=yydf;
                    if(yydf0<0.4)
                        yydf=0.0
                    if(yydf0>0.4)
                        yydf=0.5
                    if(yydf0>0.7)
                        yydf=1.0
                    if(yydf0>1.0)
                        yydf=1.5
                    if(yydf0>1.3)
                        yydf=2.0

                    //语序得分
                    var yxdf1=sendspeechsystem.getScoreZh(zhstr,standerzh)
                    var yxdf2=sendspeechsystem.getScoreEn(enstr,standeren)
                    var yxdf=(yxdf2*2+3)/3.5
                    var yxdf0=yxdf;
                    if(yxdf0<0.5)
                        yxdf=0.0
                    if(yxdf0>0.6)
                        yxdf=0.5
                    if(yxdf0>0.7)
                        yxdf=1.0
                    if(yxdf0>1.1)
                        yxdf=1.5
                    if(yxdf0>1.3)
                        yxdf=2.0

                    //流利度得分
                    var llddf=(gjzdf*2+yydf*2+yxdf)/5
                    var llddf0=llddf;
                    if(llddf0<0.5)
                        llddf=0.0
                    if(llddf0>0.5)
                        llddf=0.5
                    if(llddf0>0.7)
                        llddf=1.0
                    if(llddf0>1.1)
                        llddf=1.5
                    if(llddf0>1.3)
                        llddf=2.0

                    //综合得分，有权重
                    var zhdf=(gjzdf*8+llddf+yydf*8+yxdf*2)/19
                    var zhdf0=zhdf;
                    if(zhdf0<0.5)
                        zhdf=0.0
                    if(zhdf0>0.5)
                        zhdf=0.5
                    if(zhdf0>0.8)
                        zhdf=1.0
                    if(zhdf0>1.1)
                        zhdf=1.5
                    if(zhdf0>1.4)
                        zhdf=2.0





                    if(hack==0){

                        var str="关键字得分："+gjzdf.toFixed(1)+"###流利度得分："+llddf.toFixed(1)+"###语义得分："+yydf.toFixed(1)+"###语序得分："+yxdf.toFixed(1)+"###综合评分："+zhdf.toFixed(1)+"###教师尚未评分"
                        mainrect.parent.parent.settestscore(tihaobox.currentIndex,str)

                    }


                    if(hack==1){
                        var str="关键字得分：1.5"+"###流利度得分：2.0"+"###语义得分：1.5"+"###语序得分：1.5"+"###综合评分：1.5"+"###教师尚未评分"
                        mainrect.parent.parent.settestscore(tihaobox.currentIndex,str)
                    }

                    if(hack==-1){
                        var str="关键字得分：0.5"+"###流利度得分：1.0"+"###语义得分：0.5"+"###语序得分：0.5"+"###综合评分：0.5"+"###教师尚未评分"
                        mainrect.parent.parent.settestscore(tihaobox.currentIndex,str)
                    }

                    luyintext.text="√"
                    tihaobox.enabled=true
                }
                else{
                    enstr=Statue
                    sendspeechsystem.transSpeech(Statue)
                }
            }

        }
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
        id:headname
        text:"考试"
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
                hack=0;
                tihaobox.currentIndex=0;
            }
        }
    }


    Label{
        id:cankaodaanbox
        text:"China has a pressing need to develop agriculture which uses water efficiently in a bid to ensure security of food supplies and alleviate poverty in its vast arid areas."
        visible: false
    }


    Label{
        id:tihao
        text:"题号："
        anchors.right: tihaobox.left
        anchors.leftMargin: width/3
        anchors.top: head.bottom
        anchors.topMargin: height*2
        verticalAlignment: Text.AlignVCenter
        font{
            pointSize: 14
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
            shangchuantext.text="▲"
            if(currentText=="考试1"){
                timubox.text="为保证广大干旱地区的粮食供应和消灭贫穷，中国迫切需要发展有效利用水资源的农业。"
                cankaodaanbox.text="China has a pressing need to develop agriculture which uses water efficiently in a bid to ensure security of food supplies and alleviate poverty in its vast arid areas."

                if(isdone[0]){
                    mask.visible=true
                    mask2.visible=true
                    luyinarea.enabled=false
                    luyintext.text="√"
                }
                else{
                    reset()
                }

            }
            if(currentText=="考试2"){
                timubox.text="1994年世界银行发表一份报告便得出结论：招收女童入学很可能是今日发展中国家唯一最有效的消除贫困的政策。"
                cankaodaanbox.text="A 1994 World Bank report concluded that enrolling girls in school was probably the single most effective antipoverty policy in the developing world today."
                if(isdone[1]){
                    mask.visible=true
                    mask2.visible=true
                    luyinarea.enabled=false
                    luyintext.text="√"
                }
                else{
                    reset()
                }
            }
            if(currentText=="考试3"){
                timubox.text="我们衷心希望这种类型的活动可以促进和加强中国和英国之间的教育交流与合作"
                cankaodaanbox.text="We sincerely hope that this type of activity can promote and strengthen educational exchanges and cooperation between China and the United Kingdom."
                if(isdone[2]){
                    mask.visible=true
                    mask2.visible=true
                    luyinarea.enabled=false
                    luyintext.text="√"
                }
                else{
                    reset()
                }
            }
        }
    }

    Rectangle{
        id:chakanpingfen

        height:tihaobox.height*1.2
        width: height

        anchors.left: parent.left
        anchors.leftMargin: width*2

        anchors.top: tihaobox.bottom
 anchors.topMargin: height
 color:m1.pressed?GlobalColor.ShareMSG:GlobalColor.Main

        radius: height/2

        Label{
            text: "查"
            color: "white"
            font{
                bold:true;
                pointSize: 20
            }
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        MouseArea{
            id:m1
            anchors.fill: parent
            onClicked: {
                mainrect.parent.parent.settestscorevisible(tihaobox.currentIndex)

            }
        }
    }

    Rectangle{
        id:shangchuan

        height:tihaobox.height*1.2
        width: height

        anchors.right: parent.right
        anchors.rightMargin: width*2

        anchors.top: tihaobox.bottom
        anchors.topMargin: height/1.5
radius: height/2
color:m2.pressed?GlobalColor.ShareMSG:GlobalColor.Main

        Label{
            id:shangchuantext
            text: "▲"
            color: "white"
            font{
                bold:true
                pointSize: 20
            }
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

        }
        MouseArea{
            id:m2
            anchors.fill: parent
            onClicked: {
                if(isdone[tihaobox.currentIndex]===0){
                sendspeechsystem.upload()
                isdone[tihaobox.currentIndex]=1;
                }
shangchuantext.text=".."
            }
        }
    }

    TextField {
        id:timubox
        text:"为保证广大干旱地区的粮食供应和消灭贫穷，中国迫切需要发展有效利用水资源的农业。"
        wrapMode: Text.Wrap
        color:"white"
        font{
            pointSize: 16
        }

        readOnly:true
        anchors.top: shangchuan.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: shangchuan.height
        anchors.bottom: shitingluyin.top
        background: Rectangle {
            anchors.fill: parent
            opacity: 0.3
            border.width: 2
            border.color: GlobalColor.Main
        }

        Rectangle{
            id:mask
            anchors.fill: parent

            Label {
                text:"点击开始作答后开始录音"
                wrapMode: Text.Wrap
                color:"grey"
                font{
                    pointSize: 16
                }
                anchors.centerIn: parent
            }
            Rectangle{
                id:mask2
                anchors.fill: parent
                Label {

                    text:"你已作答此题！"
                    wrapMode: Text.Wrap
                    color:"grey"
                    font{
                        pointSize: 16
                    }

                    anchors.centerIn: parent

                }
                visible: false
            }
        }
    }

    Rectangle{
        id:kaishiluyin

        height:tihaobox.height*1.2
        width: height

        anchors.left: parent.left
        anchors.leftMargin: width*2

        anchors.bottom: parent.bottom
        anchors.bottomMargin: height
radius: height/2
color:luyinarea.pressed?GlobalColor.ShareMSG:GlobalColor.Main

        Label{
            id:luyintext
            text: "答"
            color: "white"
            font{
                bold:false
                pointSize: 20
            }
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

        }
        MouseArea{
            id:luyinarea
            property int recording: 0
            anchors.fill: parent
            onClicked: {

                if(recording==0){
                    back.visible=false
                    sendspeechsystem.inclick(username+tihaobox.currentIndex.toString())
                    luyinarea.recording=1
                    luyintext.text="■"
                    mask.visible=false
                    tihaobox.enabled=false

                }
                else{
                    back.visible=true
                    sendspeechsystem.outclick("en",username+tihaobox.currentIndex.toString())
                    luyinarea.enabled=false
                    luyintext.text="√"
                    recording=0
                }
            }
        }



    }

    Rectangle{
        id:shitingluyin

        height:tihaobox.height*1.2
        width: height

        anchors.right: parent.right
        anchors.rightMargin: width*2

        anchors.bottom: parent.bottom
        anchors.bottomMargin: height
radius: height/2
color:m4.pressed?GlobalColor.ShareMSG:GlobalColor.Main

        Label{
            text: "▶"
            color: "white"
            font{
                bold:true
                pointSize: 30
            }
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

        }
        MouseArea{
            id:m4
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
