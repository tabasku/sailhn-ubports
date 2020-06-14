import QtQuick 2.7
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
        id: mainPage
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Top')

            StyleHints {
                //foregroundColor: UbuntuColors.black
                backgroundColor: "#ff6600"
                dividerColor: UbuntuColors.slate
            }

            leadingActionBar {
                numberOfSlots: 0
                actions: tabsList.actions
            }

            trailingActionBar.actions: [
            Action {
                iconName: "add"
                text: i18n.tr("Submit")
                onTriggered: {
                    console.log("submit")
                    //podcastPage.header = searchHeader
                    //searchField.item.forceActiveFocus()
                }
            }
        ]
        }

        Rectangle{
            color: "#f6f6ef"
            anchors.fill: parent
        }

        /* UbuntuListView Component add at QML ListView additional features such as expanding/collapsing items */
        StoriesListView {
            id:  listView

            anchors{
                fill: parent
                topMargin: header.height + units.gu(0.5)
            }
            //anchors.fill: parent
            //anchors.top: header.bottom
            /* amount of space from the above component */
            //anchors.topMargin: units.gu(15)

            /* disable the dragging features of the ListModel elements */
            boundsBehavior: Flickable.StopAtBounds

            focus: true
            /* set clip:true to prevent that UbuntuListView draw out of his assigned rectangle, default is false */
            clip: true

            PullToRefresh {
                //refreshing: listView.model.status === XmlListModel.Loading
                onRefresh: listView.refreshClicked()
            }
        }

        // /* to have a scroll bar we ListModel size exceed the page heigth */
        // Scrollbar {
        //     flickableItem: listView
        //     align: Qt.AlignTrailing
        //     Layout.fillHeight: true
        //     Layout.fillWidth: true
        //     // Layout.alignment: Qt.AlignTop
        //     anchors {
        //     //     horizontalCenter: parent.horizontalCenter
        //     //     top: header.bottom
        //     //     topMargin: units.gu(5)
        //     //     bottomMargin: units.gu(5)
        //          fill:parent
        //    }
        // }
        // Scrollbar for categoryColumnFlickable
        Scrollbar {
            z: 1
            flickableItem: listView
            align: Qt.AlignTrailing
        }

        Component.onCompleted: loadStories();

        function loadStories() {
            listView.stories.loadTopStories();
        }
    }