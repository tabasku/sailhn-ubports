/*
  The MIT License (MIT)

  Copyright (c) 2015-2016 Andrea Scarpino <me@andreascarpino.it>

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
*/

#ifndef NEWSMODEL_H
#define NEWSMODEL_H

#include <QAbstractListModel>

class Item;
class HackerNewsAPI;

class NewsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum NewsRoles {
        IdRole = Qt::UserRole + 1,
        ByRole = Qt::UserRole + 2,
        DeadRole = Qt::UserRole +  3,
        DescendantsRole = Qt::UserRole + 4,
        KidsRole = Qt::UserRole + 5,
        ParentRole = Qt::UserRole + 6,
        ScoreRole = Qt::UserRole + 7,
        TextRole = Qt::UserRole + 8,
        TimeRole = Qt::UserRole + 9,
        TitleRole = Qt::UserRole + 10,
        UrlRole = Qt::UserRole + 11
    };

    explicit NewsModel(QObject *parent = 0);
    virtual ~NewsModel();

    virtual int rowCount(const QModelIndex&) const { return backing.size(); }
    virtual QVariant data(const QModelIndex &index, int role) const;

    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void loadAskStories();
    Q_INVOKABLE void loadBestStories();
    Q_INVOKABLE void loadNewStories();
    Q_INVOKABLE void loadJobStories();
    Q_INVOKABLE void loadShowStories();
    Q_INVOKABLE void loadTopStories();
    Q_INVOKABLE void loadComments(const QList<int> kids);
    Q_INVOKABLE void nextItems();
    Q_INVOKABLE void refresh(const int itemId);

private:
    void loadItems();
    void onItemFetched(Item *item);
    void onRefreshComments(Item *item);
    void onStoriesFetched(QList<int> ids);
    void reset();

    QVector<Item*> backing;
    HackerNewsAPI *api;
    QList<int> m_ids;
    int m_start;
    int m_end;
};

#endif // NEWSMODEL_H
