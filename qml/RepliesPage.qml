import QtQuick 2.7
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import sailhn.sailhn 1.0

Page {
    property var dead
    property var kids
    property var parentId

    readonly property int maxCommentsForPage: 30
    property int showingCommentsCount: maxCommentsForPage

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

    Flickable {
        id: replies
        anchors.fill: parent
        contentHeight: column.height

        /*
        PullDownMenu {

            MenuItem {
                id: reply
                text: qsTr("Reply")
                enabled: !dead

                onClicked: pageStack.push(Qt.resolvedUrl("Reply.qml"), {parentId: parentId})
            }

            MenuItem {
                text: qsTr("Refresh")

                onClicked: {
                    model.refresh(parentId);
                    showingCommentsCount = maxCommentsForPage;
                }
            }
        }

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

            /*
            SectionHeader {
                text: qsTr("Replies")
            }
            */

            Repeater {

                model: NewsModel {
                    id: model

                    /*onRowsInserted: {
                        if (kids.length > showingCommentsCount) {
                            replies.pushUpMenu.visible = true;
                        }
                    }*/
                }

                delegate: ReplyDelegate {}
            }
        }

    }

    Component.onCompleted: {
        //reply.enabled = manager.isAuthenticated();
        loadComments();
    }

    function loadComments() {
        model.loadComments(kids);
    }
}
