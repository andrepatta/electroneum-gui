#ifndef ADDRESSBOOK_H
#define ADDRESSBOOK_H

#include <wallet/wallet2_api.h>
#include <QObject>
#include <QList>
#include <QDateTime>

namespace Electroneum {
class AddressBook;
}
class AddressBookRow;

class AddressBook : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QList<Electroneum::AddressBookRow*> getAll(bool update = false) const;
    Q_INVOKABLE Electroneum::AddressBookRow * getRow(int index) const;
    Q_INVOKABLE bool addRow(const QString &address, const QString &payment_id, const QString &description) const;
    Q_INVOKABLE bool deleteRow(int rowId) const;
    quint64 count() const;
    Q_INVOKABLE QString errorString() const;
    Q_INVOKABLE int errorCode() const;
    Q_INVOKABLE int lookupPaymentID(const QString &payment_id) const;

    enum ErrorCode {
        Status_Ok,
        General_Error,
        Invalid_Address,
        Invalid_Payment_Id
    };

    Q_ENUM(ErrorCode);


signals:
    void refreshStarted() const;
    void refreshFinished() const;


public slots:

private:
    explicit AddressBook(Electroneum::AddressBook * abImpl, QObject *parent);
    friend class Wallet;
    Electroneum::AddressBook * m_addressBookImpl;
    mutable QList<Electroneum::AddressBookRow*> m_rows;
};

#endif // ADDRESSBOOK_H
