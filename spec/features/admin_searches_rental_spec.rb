require 'rails_helper'

feature 'Admin searches rental' do
    scenario 'and find exact match' do
        client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com', cpf: '123.456.789-00')
        car_category = CarCategory.create!(name: 'A', daily_rate: 1, car_insurance: 1, third_party_insurance: 1)
        user = User.create!(name: 'Sicrano Fulano', email: 'client@test.com', password: '12345678' )
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, user: user, client: client, car_category: car_category)

        another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, user: user, client: client, car_category: car_category)


        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: rental.token
        click_on 'Buscar'

        expect(page).to have_content(rental.token)
        expect(page).not_to have_content(another_rental.token)
        expect(page).to have_content(rental.client.name)
        expect(page).to have_content(rental.client.email)
        expect(page).to have_content(rental.client.cpf)
        expect(page).to have_content(rental.user.email)
        expect(page).to have_content(rental.car_category.name)
    end
    xscenario 'and finds nothing' do
    end

    scenario 'finds by partial token' do
        client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com', cpf: '123.456.789-00')
        car_category = CarCategory.create!(name: 'A', daily_rate: 1, car_insurance: 1, third_party_insurance: 1)
        user = User.create!(name: 'Sicrano Fulano', email: 'client@test.com', password: '12345678' )
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, user: user, client: client, car_category: car_category)
        rental.update(token: 'ABC123')
        another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, user: user, client: client, car_category: car_category)
        another_rental.update(token: 'ABC567')
        rental_not_to_be_found = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, user: user, client: client, car_category: car_category)

        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: 'ABC'
        click_on 'Buscar'

        expect(page).to have_content(rental.token)
        expect(page).to have_content(another_rental.token)
        expect(page).not_to have_content(rental_not_to_be_found.token)
    end
end