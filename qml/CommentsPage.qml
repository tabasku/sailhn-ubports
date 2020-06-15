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

    header: PageHeader {
        id: header
        title: i18n.tr('Comments')

        StyleHints {
            foregroundColor: UbuntuColors.inkstone
            backgroundColor: headerBackgroundColor
            //dividerColor: "transparent"
        }

        trailingActionBar.actions: [
            Action {
                iconName: "message"
                text: i18n.tr("Reply")
                onTriggered: {
                    pageStack.push(Qt.resolvedUrl("Reply.qml"), {parentId: parentId})
                }
            }
        ]
    }

    Rectangle{
        color: storyBackgroundColor
        anchors.fill: parent
    }

    Flickable {
        id: comments
        contentHeight: column.height

        anchors{
            fill: parent
            topMargin: header.height + units.gu(1)
        }

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
            //x: units.gu(1)
            width: parent.width - units.gu(1) * 2
            spacing: units.gu(1)
            padding:  units.gu(1)

            Label {
                width: parent.width
                text: title
                color: theme.palette.highlighted.baseText
                textSize: Label.Medium
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
                wrapMode: Text.WordWrap

                onLinkActivated: {
                    console.log("Opening external browser: " + link);
                    Qt.openUrlExternally(link)
                }
            }

            // Workaround for Label that does not provide onClick?
            Text {
                //width: parent.implicitWidth //craches with padding
                width:parent.width
                visible: (url && !(/^\s*$/.test(url)))
                textFormat: Text.RichText

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
                textSize: Label.Medium
                //horizontalAlignment: Text.AlignRight
                text: by + " - " + Qt.formatDateTime(time, "ddd, hh:mm");
            }

            Repeater {

                model: NewsModel {
                    id: model

                    // onRowsInserted: {
                    //     if (kids.length > showingCommentsCount) {
                    //         comments.pushUpMenu.visible = true;
                    //     }
                    // }
                }

                delegate: ReplyDelegate {}
            }
        }

    }

    Component.onCompleted: {
        loadComments();
        //reply.enabled = manager.isAuthenticated();
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
