require 'rails_helper'

describe Phone do
  it 'does not allow duplicate numbers per contact' do
    contact = Contact.create(
      firstname: 'Peter',
      lastname: 'Testboro',
      email: 'testman@example.org'
    )

    contact.phones.create(
      phone_type: 'home',
      phone: '555-847-1234'
    )

    mobile_phone = contact.phones.build(
      phone_type: 'mobile',
      phone: '555-847-1234'
    )

    mobile_phone.valid?
    expect(mobile_phone.errors[:phone]).to include('has already been taken')
  end

  it 'does allow two contacts to share a number' do
    contact = Contact.create(
      firstname: 'Peter',
      lastname: 'Testboro',
      email: 'testman@example.org'
    )

    contact.phones.create(
      phone_type: 'home',
      phone: '555-847-1234'
    )

    other_contact = Contact.new
    other_phone = other_contact.phones.build(
      phone_type: 'home',
      phone: '555-847-1234'
    )
    expect(other_phone).to be_valid
  end
end
