import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3

Page {
    property var parentId

    header: PageHeader {
        id: header
        title: i18n.tr('Replies')

        StyleHints {
            foregroundColor: UbuntuColors.inkstone
            backgroundColor: headerBackgroundColor
            dividerColor: UbuntuColors.ash
        }
    }


    Rectangle{
        color: storyBackgroundColor
        anchors.fill: parent
    }

    Connections {
        target: manager

        onCommented: {
            console.log("Commented: " + result);

            busy.visible = busy.running = false;
            send.enabled = true;
            msg.visible = true;

            if (!result) {
                msg.text = qsTr("Error when sending");
            } else {
                msg.text = qsTr("Commented!");
            }
        }
    }

    Flickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            x: units.gu(2)
            width: parent.width - units.gu(2)n * 2

            PageHeader {
                title: qsTr("Reply")
            }

            TextArea {
                id: comment
                width: parent.width
                focus: true
                placeholderText: qsTr("Text")
            }

            Button {
                id: send
                text: qsTr("Add Comment");
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    if (comment.text.length > 0) {
                        manager.comment(parentId, comment.text);
                        send.enabled = false;
                        busy.visible = busy.running = true;
                        msg.visible = false;
                    }
                }
            }

            Label {
                id: msg
                visible: false
                color: theme.palette.highlighted.baseText
                anchors.horizontalCenter: parent.horizontalCenter
            }

            BusyIndicator {
                id: busy
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
