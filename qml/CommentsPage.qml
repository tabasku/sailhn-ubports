import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import sailhn.sailhn 1.0

Page {
    property var id
    property var by
    property var dead
    property var itemText
    property var kids
    property var time
    property var title
    property var url

    readonly property int maxCommentsForPage: 30
    property int showingCommentsCount: maxCommentsForPage

    //allowedOrientations: Orientation.All

    Flickable {
        id: comments
        anchors.fill: parent
        contentHeight: column.height

    /*        PullDownMenu {
            MenuItem {
                text: qsTr("Copy external url")

                onClicked: {
                    Clipboard.text = url;
                }
            }

            MenuItem {
                id: reply
                text: qsTr("Reply")
                enabled: !dead

                onClicked: pageStack.push(Qt.resolvedUrl("Reply.qml"), {parentId: id})
            }

            MenuItem {
                text: qsTr("Refresh")

                onClicked: {
                    model.refresh(id);
                    showingCommentsCount = maxCommentsForPage;
                }
            }
        }*/
/*
        PushUpMenu {
            visible: false

            MenuItem {
                text: qsTr("Load more")

                onClicked: {
                    model.nextItems();
                    showingCommentsCount += maxCommentsForPage;
                }
            }
        }*/

        Column {
            id: column
            x: units.gu(2)
            width: parent.width - units.gu(2) * 2
            spacing: units.gu(2)

            // SectionHeader {
            //     text: qsTr("Comments")
            // }

            Label {
                width: parent.width
                text: title
                color: theme.palette.highlighted.baseText
                //font.pixelSize: Theme.fontSizeMedium
                wrapMode: Text.Wrap
            }

            Text {
                width: parent.implicitWidth
                visible: (itemText && !(/^\s*$/.test(itemText)))
                textFormat: Text.RichText
                text: "<style>a:link{color: " + theme.palette.highlighted.baseText + ";}</style>" + itemText
                color: theme.palette.normal.baseText
                //font.pixelSize: Theme.fontSizeMedium
                wrapMode: Text.Wrap

                onLinkActivated: {
                    console.log("Opening external browser: " + link);
                    Qt.openUrlExternally(link)
                }
            }

            // Workaround for Label that does not provide onClick?
            Text {
                width: parent.implicitWidth
                visible: (url && !(/^\s*$/.test(url)))
                textFormat: Text.RichText
                //font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WrapAnywhere
                text: {
                    var txt = "<style>a:link{color: " + theme.palette.highlighted.baseText + ";}</style>";
                    txt += "<a href=\"" + url + "\" rel=\"nofollow\">" + url + "</a>";
                    return txt;
                }

                onLinkActivated: {
                    console.log("Opening external browser: " + link);
                    Qt.openUrlExternally(link);
                }
            }

            Label {
                width: parent.width
                color: theme.palette.highlighted.baseText
                //font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignRight
                text: by + " - " + Qt.formatDateTime(time, "ddd, hh:mm");
            }

            Repeater {

                model: NewsModel {
                    id: model

                    /*onRowsInserted: {
                        if (kids.length > showingCommentsCount) {
                            comments.pushUpMenu.visible = true;
                        }
                    }*/
                }

                delegate: ReplyDelegate {}
            }
        }

    }

    Component.onCompleted: {
        loadComments();
        reply.enabled = manager.isAuthenticated();
    }

    /*
    onStatusChanged: {
        if (status == PageStatus.Active) {
            if (url && !(/^\s*$/.test(url))) {
                pageStack.pushAttached(Qt.resolvedUrl("ItemWebView.qml"), { itemUrl: url });
            }
        }
    }
    */

    function loadComments() {
        model.loadComments(kids);
    }
}
