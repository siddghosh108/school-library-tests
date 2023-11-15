require 'rspec'
require_relative '../classes/person'

describe Person do
  let(:person) { Person.new(25, 'John', parent_permission: false) }

  describe 'Initialization' do
    it 'initializes with age, name, and parent permission' do
      # Initialization with age, name, and parent permission and empty rentals array
      expect(person.age).to eq(25)
      expect(person.name).to eq('John')
      expect(person.parent_permission).to be_falsey
      expect(person.rentals).to eq([])
    end

    it 'initializes with a unique ID' do
      # Initialization with a unique ID
      expect(person.id).to be_a(Integer)
    end

    it 'initializes with default name "Unknown" if name is not provided' do
      # Default name should be Unknown if the name is not provided
      person_without_name = Person.new(30)
      expect(person_without_name.name).to eq('unknown')
    end
  end

  describe 'Permission Checks' do
    it 'can use services with parent permission' do
      # can_use_services? method returns true with parent permission
      person_with_permission = Person.new(15, 'Bob', parent_permission: true)
      expect(person_with_permission.can_use_services?).to be_truthy
    end

    it 'cannot use services without parent permission if under age' do
      # can_use_services? method returns false if under age and no parent permission
      underage_person = Person.new(16, 'Alice', parent_permission: false)
      expect(underage_person.can_use_services?).to be_falsey
    end

    it 'can use services without parent permission if over age' do
      # can_use_services? method returns true if over age
      adult_person = Person.new(18, 'Eve', parent_permission: false)
      expect(adult_person.can_use_services?).to be_truthy
    end
  end

  describe 'Name Validation' do
    it 'correctly returns the name' do
      # correct_name method returns the correct name
      expect(person.correct_name).to eq('John')
    end

    it 'does not correct the name' do
      # correct_name method does not correct the name
      person_with_long_name = Person.new(30, 'alongnameiscorrected')
      expect(person_with_long_name.correct_name).to eq('alongnameiscorrected')
    end
  end

  describe 'Rental Management' do
    it 'can add a rental and return it' do
      # add_rental method returns a rental and adds it to the rentals array
      rental = double('Rental')
      expect(person.add_rental(rental)).to eq([rental])
      expect(person.rentals).to include(rental)
    end
  end
end
