#ifndef SPEECHSYSTEM_H
#define SPEECHSYSTEM_H
#include <QObject>
#include<QSound>
#include <QAudioInput>
#include <QAudioOutput>
#include <QFile>
#include <QBuffer>
#include <QtNetwork/QtNetwork>
class SpeechSystem : public QObject
{
    Q_OBJECT
public:
    explicit SpeechSystem(QObject *parent = 0);
    Q_PROPERTY(QString Statue READ Statue WRITE setStatue NOTIFY statueChanged)
    QString m_Statue;
    void setStatue(QString s);
    QString Statue();

    Q_INVOKABLE void inclick(QString path);
    Q_INVOKABLE void outclick(QString lan, QString path);

    Q_INVOKABLE void playsound(QString path);
    Q_INVOKABLE void upload();

    QString TypeLabel;
    QString FileNameLabel;
    void uploadClick();
    QNetworkAccessManager *manager;

    char *cuid;
    char *audiodata;
    int content_len;
    std::string base64_encode(unsigned char const* bytes_to_encode, unsigned int in_len);
    std::string base64_decode(std::string const& encoded_string);
    void replyFinish(QNetworkReply *reply);
    QNetworkAccessManager *manager2;
    void getResult(QNetworkReply *reply);


    QFile outputFile;   // class member.
    QAudioInput* audio_in; // class member.
    QAudioOutput* audioOut;
    QFile inputFile;   // class member.
    QIODevice *myBuffer_in;


    QString TransSpeechText;
    Q_INVOKABLE void transSpeech(QString str);
    Q_INVOKABLE QString getTransSpeech();

    QNetworkAccessManager *manager3;
    void getTransSpeechResult(QNetworkReply *reply);


    Q_INVOKABLE QString getscore(QString user);
    Q_INVOKABLE QString gettestscore(QString user);
    Q_INVOKABLE void savescore(QString str,QString user);
    Q_INVOKABLE void savetestscore(QString str,QString user);

    Q_INVOKABLE float getScoreZh(QString a,QString b);
    Q_INVOKABLE float getScoreEn(QString a,QString b);

    Q_INVOKABLE float semanticScoring(std::vector<int> whichWord,std::vector<int> synonymWord,int keyWordNum,std::vector<float> vecSore);
    Q_INVOKABLE float frequecyScoring(std::vector<int> left, std::vector<int> right, int voicelength);
    Q_INVOKABLE float accurateScoring(float simScore,int keywordNum,std::vector<int> keyNum);


signals:
    void statueChanged(const QString& Statue);


};

#endif // SPEECHSYSTEM_H
