require 'rails_helper'

describe Contact do
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: 'Peter',
      lastname: 'Whistler',
      email: 'testme@example.org')
    expect(contact).to be_valid
  end

  it "is invalid without firstname" do
    contact = Contact.new(firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without lastname" do
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid without email" do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid with duplicate email" do
    Contact.create(
      firstname: 'Joe',
      lastname: 'Everyman',
      email: 'ohno@example.org'
    )

    contact = Contact.new(
      firstname: 'Jane',
      lastname: 'Everywoman',
      email: 'ohno@example.org'
    )
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "returns a contact's full name as a string" do
    contact = Contact.new(
      firstname: 'Paul',
      lastname: 'Stringy',
      email: 'stringy@example.org'
    )
    expect(contact.name).to eq('Paul Stringy')
  end

  it 'returns a sorted array of contacts matching given letter' do
    smith = Contact.create(
      firstname: 'Smithy',
      lastname: 'Null',
      email: 'smithy@test.org'
      )

    jones = Contact.create(
      firstname: 'Jonesy',
      lastname: 'Jones',
      email: 'jonesy@test.org'
    )

    james = Contact.create(
      firstname: 'Jamesy',
      lastname: 'James',
      email: 'jamesy@test.org'
    )

    expect(Contact.by_letter('J')).to eq [james, jones]
  end
end
