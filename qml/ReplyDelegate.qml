import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3

ListItem {
    height: contentItem.childrenRect.height

    Column {
        width: parent.width

        Text {
            width: parent.width
            textFormat: Text.RichText
            text: "<style>a:link{color: " + theme.palette.highlighted.baseText + ";}</style>" + itemText
            color: theme.palette.highlighted.baseText
            //font.pixelSize: Theme.fontSizeMedium
            wrapMode: Text.Wrap

            onLinkActivated: {
                console.log("Opening external browser: " + link);
                Qt.openUrlExternally(link)
            }
        }

        Label {
            width: parent.width
            color: theme.palette.highlighted.baseText
            //font.pixelSize: Theme.fontSizeSmall
            horizontalAlignment: Text.AlignRight

            text: {
                var txt = by;
                if (kids.length !== 0) {
                    txt += " - " + kids.length + ' ';
                    if (kids.length === 1) {
                        txt += qsTr("reply");
                    } else {
                        txt += qsTr("replies");
                    }
                }

                return txt + " - " + Qt.formatDateTime(time, "ddd, hh:mm");
            }
        }
    }

    onClicked: {
        if (kids.length !== 0) {
            pageStack.push(Qt.resolvedUrl("RepliesPage.qml"), {parentId: id, dead: dead, kids: kids});
        }
    }
}
