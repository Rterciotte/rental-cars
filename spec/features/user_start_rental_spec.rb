require 'rails_helper'

feature 'User start rental' do
  scenario 'successfully' do
    client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com', cpf: '123.456.789-00')
    car_category = CarCategory.create!(name: 'A', daily_rate: 1, car_insurance: 1, third_party_insurance: 1)
    user = User.create!(name: 'Sicrano Fulano', email: 'client@test.com', password: '12345678' )
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, user: user, client: client, car_category: car_category)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    car = Car.create!(license_plate: 'ABC123', color: 'Prata', car_model: car_model , mileage: 0, )
    
    login_as user, scope: :user
    
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'
    select "#{car_model.name} - #{car.color} - #{car.license_plate}", from: 'Carros disponíveis'
    click_on 'Iniciar'

    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car_category.name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(client.email)
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
  end
end