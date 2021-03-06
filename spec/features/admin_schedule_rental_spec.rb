require 'rails_helper'

feature 'Admin schedule rental' do
    scenario 'must be signed in' do
        visit root_path
        click_on 'Categorias'
    
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Para continuar, efetue login ou registre-se.'
    end
    scenario 'successfully' do
        CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, 
                            third_party_insurance: 100)
        Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-57', 
                        email: 'teste@cliente.com')
        user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                            password: '12345678')
                            
        login_as user, scope: :user
        visit root_path
        click_on 'Locações'                            
        click_on 'Agendar nova locação'
        fill_in 'Data de início', with: '21/08/2030'
        fill_in 'Data de término', with: '23/08/2030'

        select 'Fulano Sicrano - 512.129.580-57', from: 'Cliente'
        select 'A', from: 'Categoria de carro'
        click_on 'Agendar'

        expect(page).to have_content('21/08/2030')
        expect(page).to have_content('23/08/2030')
        expect(page).to have_content('512.129.580-57')
        expect(page).to have_content('teste@cliente.com')
        expect(page).to have_content('A')
        expect(page).to have_content('R$ 600,00')
        expect(page).to have_content('Agendamento realizado com sucesso')
    end
    scenario 'must fill in all fields' do
        user  = User.create!(name: 'Rogério Terciotte', 
                            email: 'rogerio@email.com', password: '12345678')
        user_login(user)    
        visit root_path
        click_on 'Locações'
        click_on 'Agendar nova locação'
        click_on 'Agendar'

        expect(page).to have_content('Data de início não pode ficar em branco')
        expect(page).to have_content('Data de término não pode ficar em branco')
        expect(page).to have_content('Cliente não pode ficar em branco')
        expect(page).to have_content('Categoria de carro não pode ficar em branco')
    end

    scenario 'must be logged in to view rentals' do
        visit root_path

        expect(page).not_to have_link('Locações')
    end

    scenario 'must be logged in to view rentals list' do
        car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, 
                            third_party_insurance: 100)
        client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-57', 
                        email: 'teste@cliente.com')
        user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                            password: '12345678')
        rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now,
                                client: client, user: user, car_category: car_category)

        visit rentals_path

        expect(current_path).to eq new_user_session_path

    end
    
    scenario 'must be logged in to view rentals details' do
        car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, 
                            third_party_insurance: 100)
        client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-57', 
                        email: 'teste@cliente.com')
        user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                            password: '12345678')
        rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now,
                                client: client, user: user, car_category: car_category)

        visit rental_path(rental)

        expect(current_path).to eq new_user_session_path
    end
    scenario 'must be logged in to schedule rental' do
        visit new_rental_path

        expect(current_path).to eq new_user_session_path
    end
end 