/* ============================================================
* QuiteRSS is a open-source cross-platform RSS/Atom news feeds reader
* Copyright (C) 2011-2021 QuiteRSS Team <quiterssteam@gmail.com>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <https://www.gnu.org/licenses/>.
* ============================================================ */
#include "webpluginfactory.h"

#include "mainapplication.h"
#include "adblockmanager.h"
#include "webpage.h"

#include <QDebug>
#include <QNetworkRequest>

WebPluginFactory::WebPluginFactory(WebPage *page)
  : QWebPluginFactory(page)
  , page_(page)
{

}

QObject* WebPluginFactory::create(const QString &mimeType, const QUrl &url,
                                  const QStringList &argumentNames,
                                  const QStringList &argumentValues) const
{
  Q_UNUSED(mimeType);
  Q_UNUSED(argumentNames);
  Q_UNUSED(argumentValues);

  if (url.isEmpty()) {
    return new QObject();
  }

  // AdBlock
  AdBlockManager* manager = AdBlockManager::instance();
  QNetworkRequest request(url);
  request.setAttribute(QNetworkRequest::Attribute(QNetworkRequest::User + 150), QString("object"));
  if (manager->isEnabled() && manager->block(request)) {
    return new QObject();
  }

  return 0;
}

QList<QWebPluginFactory::Plugin> WebPluginFactory::plugins() const
{
  QList<Plugin> plugins;
  return plugins;
}
