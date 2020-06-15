import QtQuick 2.7
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

/*
   This is the first page loaded in the PageStack on application startup
*/
Tab {
    id: topStoriesTab

    TabsList {
        id: tabsList
    }

   page: Page {
        id: mainPage

        header: PageHeader {
            id: header
            title: i18n.tr('Top')

            StyleHints {
                foregroundColor: UbuntuColors.inkstone
                backgroundColor: headerBackgroundColor
                dividerColor: "transparent"
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
            color: storyBackgroundColor
            anchors.fill: parent
        }

        /* UbuntuListView Component add at QML ListView additional features such as expanding/collapsing items */
        StoriesListView {
            id:  listView

            anchors{
                fill: parent
                topMargin: header.height + units.gu(0.5)
            }

            /* disable the dragging features of the ListModel elements */
            boundsBehavior: Flickable.StopAtBounds

            onRefreshClicked: loadStories()

            // pullToRefresh {
            //     enabled: true
            //     refreshing: false
            //     //refreshing: listView.model.status === XmlListModel.Loading
            //     onRefresh: loadStories()
            // }
        }

        Scrollbar {
            flickableItem: listView
            align: Qt.AlignTrailing
        }

        Component.onCompleted: loadStories();

        function loadStories() {
            listView.stories.loadTopStories();
        }
    }
}